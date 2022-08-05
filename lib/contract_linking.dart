import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = 'http://127.0.0.1:7545';
  final String _wsUrl = 'ws://127.0.0.1:7545';
  final String _privatekey =
      'da4d41fc776f6f654e66bad83d4704fa6c3621c3fd71cc6dca073d209e24ef0a';

  Web3Client? _web3client;
  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;

  Credentials? _credentials;

  DeployedContract? _contract;

  ContractFunction? _message;
  ContractFunction? _setMessage;
  String? deployedName;

  ContractFunction? _uris;
  ContractFunction? _createTokenURI;
  List<String>? uris;
  ContractLinking() {
    setup();
  }

  setup() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    //
    String abiStringFile =
        await rootBundle.loadString('build/contracts/CreateNFT.json');
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    //
    _credentials = EthPrivateKey.fromHex(_privatekey);
  }

  Future<void> getDeployedContract() async {
    //
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "CreateNFT"), _contractAddress!);

    _uris = _contract!.function('getAllTokenURIs');
    _createTokenURI = _contract!.function('createTokenURI');
    getURIs();
  }

  getURIs() async {
    // ignore: no_leading_underscores_for_local_identifiers
    var web3client = _web3client;
    final _myuris = await web3client!
        .call(contract: _contract!, function: _uris!, params: []);
    uris = (_myuris[0] as List<dynamic>).map((e) => e.toString()).toList();
    isLoading = false;
    notifyListeners();
  }

  createTokenURi(String uri) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
      _credentials!,
      Transaction.callContract(
        contract: _contract!,
        function: _createTokenURI!,
        parameters: [uri],
      ),
    );
    await getURIs();
  }
}

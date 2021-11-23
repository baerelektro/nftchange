pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract nftchange {

    event newNFT(address NFTSend, uint8 figur);
    event changeNFT(address NFTreceive, address NFTsend);
    event ConfirmChange(address NFTreceive, address NFTSend);

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
    // Мапа с НФтишками и их хозяевами 
    mapping (address => address) public NFTToOwner;
    // Нфтшка хочет быть обменен на 6 пешка, 5 ладья, 4 конь, 3 слон, 2 ферзь, 1 король
    mapping (address => uint8) public NFTToFigure;
    // Предложения обмена
    mapping (address => address) public Exchange;
    // Согласия обмена
    mapping (address => address) public Confirm;

    // Присылаем НФТшку в обменник и пожелание игуры для замены
    function OfferExchange (address NFTSend, uint8 figur) public  {
        require(IsNFTOwner(msg.sender, NFTSend));
        NFTToOwner[msg.sender] = NFTSend;
        NFTToFigure[NFTSend] = figur;
        emit newNFT(NFTSend, figur);
    }
    // Присылаем НФТшку и предлагаем её в обмен на другую
    function AgreeExchange (address NFTreceive, address NFTSend) public {
        require(IsNFTOwner(msg.sender, NFTSend));
        Exchange[NFTreceive] = NFTSend;
        emit changeNFT(NFTreceive, NFTSend); 
    }
    //  Оба участника подтверждашт обмен
    function ConfirmExchange (address NFTreceive, address NFTSend) public {
        require(IsNFTOwner(msg.sender, NFTSend));
        Confirm[NFTreceive] = NFTSend;
        emit ConfirmChange(NFTreceive, NFTSend);
    }

    function IsNFTOwner(address Owner, address NFT) public view returns(bool) {
         // Тут добавим проверку обладания НФТшкой, если проходит то шлём true
         return(true);
    }

}

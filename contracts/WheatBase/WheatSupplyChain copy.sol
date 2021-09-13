// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '../WheatCore/Ownable.sol';
import '../WheatAccessControl/FarmerRole.sol';
import '../WheatAccessControl/SiloRole.sol';
import '../WheatAccessControl/TransporterRole.sol';
import '../WheatAccessControl/MillRole.sol';
import '../WheatAccessControl/DistributorRole.sol';
import '../WheatAccessControl/RetailerRole.sol';
import '../WheatAccessControl/ConsumerRole.sol';

// Define a contract 'Supplychain'
contract SupplyChain is 
  Ownable,
  FarmerRole,
  SiloRole,
  TransporterRole,
  MillRole,
  DistributorRole,
  RetailerRole,
  ConsumerRole {

    // Define Owner

    address owner;

    // universal product code

    uint upc;

    // batch number 

    uint batchID;

    // map the final product through its upc

    mapping (uint => Product ) products;

    // mapping producthistory

    mapping (uint => Txblocks) productHistory;

    enum State {
        FarmedByFarmer, //0
        HarvestedByFarmer, //1
        StoredByFarmer, //2
        ForSaleByFarmer,//3

        BoughtBySilo,//4
        
        InspectedBySilo,//5
        StoredBySilo,//6
        ForSaleBySilo,//7
        
        BoughtByMill,//8
        
        ShipBySilo,//9
        
        ExportByTransporter,//10
        
        RecieveByMill,//11
        ProcessByMill,//12
        PackageByMill,//13
        ForSaleByMill,//14
        
        BoughtByDistributor,//15
        
        ShipByMill,//16
        
        RecieveByDistributor,//17
        StoreByDistributor,//18
        ForSaleByDistributor,//19
        
        BoughtByRetailer,//20
        
        ShipByDistributor,//21
        
        RecieveByRetailer,//22
        StackByRetailer,//23
        ForSaleByRetailer,//24
        
        BoughtByConsumer//25   
    }

    State constant defaultState = State.FarmedByFarmer;
    
    // defining product attributes
    
    struct Product {

        address ownerID;
        uint productID;

        uint upc;
        uint batchID;
        address farmID;
        string farmInfo;
        string harvestDetail;
        string storageInfoFarm;
        string farmChemicals;
        uint256 farmDate;
        uint256 harvestDate;

        address siloID;
        string siloInfo;
        string certificateOfInspection;
        string processingInfoSilo;
        string storageInfoSilo;
        uint256 arrivalDateSilo;
        uint256 shippingDateSilo;

        address transporterID;
        string transportInfo;
        string transitDocument;
        uint256 arrivalDateTrans;
        uint256 shippingtDateTrans;

        address millID;
        string millInfo;
        string processingInfoMill;
        string storageInfoMill;
        string packagingInfo;
        string productDetailMill;
        uint256 arrivalDateMill;
        uint256 shippingDateMill;

        address distributorID;
        string storageInfoDist;
        string shipmentInfo;
        uint256 arrivalDateDist;
        uint256 shippingDateDist;

        address retailerID;
        string stackInfoRet;
        uint256 arrivalDateRet;

        address consumerID;
        string consumerInfo;
        uint256 purchaseDate;

        State productState;

    }

    //BlockNumber struct

    struct Txblocks {

        uint FTS;
        uint STT;
        uint TTM;
        uint MTD;
        uint DTR;
        uint RTC;
        
    }

// events
    event FarmedByFarmer(uint upc);
    event HarvestedByFarmer(uint upc);
    event StoredByFarmer(uint upc);
    event ForSaleByFarmer(uint upc);
    event BoughtBySilo(uint upc);
    event InspectedBySilo(uint upc);
    event StoredBySilo(uint upc);
    event ForSaleBySilo(uint upc);
    event BoughtByMill(uint upc);
    event ShipBySilo(uint upc);
    event ExportByTransporter(uint upc);
    event RecieveByMill(uint upc);
    event ProcessByMill(uint upc);
    event PackageByMill(uint upc);
    event ForSaleByMill(uint upc);
    event BoughtByDistributor(uint upc);
    event ShipByMill(uint upc);
    event RecieveByDistributor(uint upc);
    event StoreByDistributor(uint upc);
    event ForSaleByDistributor(uint upc);
    event BoughtByRetailer(uint upc);
    event ShipByDistributor(uint upc);
    event RecieveByRetailer(uint upc);
    event StackByRetailer(uint upc);
    event ForSaleByRetailer(uint upc);
    event BoughtByConsumer(uint upc);

      // Define a modifer that checks to see if msg.sender == owner of the contract
  modifier onlyOwner() override{
    require(msg.sender == owner);
    _;
  }

  // Define a modifer that verifies the Caller
  modifier verifyCaller (address _address) {
    require(msg.sender == _address);
    _;
  }
  
  //product state modifier

  modifier farmedByFarmer(uint _upc){
    require(products[_upc].productState == State.FarmedByFarmer);
    _;
}//1
  modifier harvestedByFarmer(uint _upc){
    require(products[_upc].productState == State.HarvestedByFarmer);
    _;
}//2
  modifier storedByFarmer(uint _upc){
    require(products[_upc].productState == State.StoredByFarmer);
    _;
}//3
  modifier forSaleByFarmer(uint _upc){
    require(products[_upc].productState == State.ForSaleByFarmer);
    _;
}//4
  modifier boughtBySilo(uint _upc){
    require(products[_upc].productState == State.BoughtBySilo);
    _;
}//5
  modifier inspectedBySilo(uint _upc){
    require(products[_upc].productState == State.InspectedBySilo);
    _;
}//6
  modifier storedBySilo(uint _upc){
    require(products[_upc].productState == State.StoredBySilo);
    _;
}//7
  modifier forSaleBySilo(uint _upc){
    require(products[_upc].productState == State.ForSaleBySilo);
    _;
}//8
 modifier boughtByMill(uint _upc){
    require(products[_upc].productState == State.BoughtByMill);
    _;
}//25
  modifier shipBySilo(uint _upc){
    require(products[_upc].productState == State.ShipBySilo);
    _;
}//9
  modifier exportByTransporter(uint _upc){
    require(products[_upc].productState == State.ExportByTransporter);
    _;
}//10
  modifier recieveByMill(uint _upc){
    require(products[_upc].productState == State.RecieveByMill);
    _;
}//11
  modifier processByMill(uint _upc){
    require(products[_upc].productState == State.ProcessByMill);
    _;
}//12
  modifier packageByMill(uint _upc){
    require(products[_upc].productState == State.PackageByMill);
    _;
}//13
  modifier forSaleByMill(uint _upc){
    require(products[_upc].productState == State.ForSaleByMill);
    _;
}//14
  modifier boughtByDistributor(uint _upc){
    require(products[_upc].productState == State.BoughtByDistributor);
    _;
}//15
  modifier shipByMill(uint _upc){
    require(products[_upc].productState == State.ShipByMill);
    _;
}//16  
modifier recieveByDistributor(uint _upc){
    require(products[_upc].productState == State.RecieveByDistributor);
    _;
}//17
  modifier storeByDistributor(uint _upc){
    require(products[_upc].productState == State.StoreByDistributor);
    _;
}//18
  modifier forSaleByDistributor(uint _upc){
    require(products[_upc].productState == State.ForSaleByDistributor);
    _;
}//19
  modifier boughtByRetailer(uint _upc){
    require(products[_upc].productState == State.BoughtByRetailer);
    _;
}//26
  modifier shipByDistributor(uint _upc){
    require(products[_upc].productState == State.ShipByDistributor);
    _;
}//20
  modifier recieveByRetailer(uint _upc){
    require(products[_upc].productState == State.RecieveByRetailer);
    _;
}//21
  modifier stackByRetailer(uint _upc){
    require(products[_upc].productState == State.StackByRetailer);
    _;
} //22
 modifier forSaleByRetailer(uint _upc){
    require(products[_upc].productState == State.ForSaleByRetailer);
    _;
}//23
  modifier boughtByConsumer(uint _upc){
    require(products[_upc].productState == State.BoughtByConsumer);
    _;
}//24

// first deployement setup

constructor()  {
  owner = msg.sender;
  batchID = 1;
  upc = 1;
}


function farmWheatByFarmer ( uint _upc, string memory _farmInfo, string memory _farmChemicals) public 
onlyFarmer() {

address siloID;
address transporterID;
address millID;
address distributorID;
address retailerID;
address consumerID;

Product memory newWheat;

newWheat.batchID = batchID;
newWheat.upc = _upc;
newWheat.ownerID = msg.sender;
newWheat.farmID = msg.sender;
newWheat.farmInfo = _farmInfo;
newWheat.farmChemicals = _farmChemicals;

newWheat.productID = _upc + batchID;
newWheat.farmDate = block.timestamp;
newWheat.productState = defaultState;

newWheat.siloID = siloID;
newWheat.transporterID = transporterID;
newWheat.millID = millID;
newWheat.distributorID = distributorID;
newWheat.retailerID =retailerID;
newWheat.consumerID = consumerID;
products[_upc] = newWheat;

uint placeholder;

Txblocks memory txBlock;

txBlock.FTS = placeholder;
txBlock.STT = placeholder;
txBlock.TTM = placeholder;
txBlock.MTD = placeholder;
txBlock.DTR = placeholder;
txBlock.RTC = placeholder;

productHistory[_upc] = txBlock;

batchID++;

emit FarmedByFarmer(_upc);


}





//         uint upc;
//         uint batchID;
//         address farmID;
//         string farmInfo;
//         string harvestDetail;
//         string storageInfoFarm;
//         string farmChemicals;
//         uint256 farmDate;
//         uint256 harvestDate;

//         address siloID;
//         string siloInfo;
//         string certificateOfInspection;
//         string processingInfoSilo;
//         string storageInfoSilo;
//         uint256 arrivalDateSilo;
//         uint256 shippingDateSilo;

//         address transporterID;
//         string transportInfo;
//         string transitDocument;
//         uint256 arrivalDateTrans;
//         uint256 shippingtDateTrans;

//         address millID;
//         string millInfo;
//         string processingInfoMill;
//         string storageInfoMill;
//         string packagingInfo;
//         string productDetailMill;
//         uint256 arrivalDateMill;
//         uint256 shippingDateMill;

//         address distributorID;
//         string storageInfoDist;
//         string shipmentInfo;
//         uint256 arrivalDateDist;
//         uint256 shippingDateDist;

//         address retailerID;
//         string stackInfoRet;
//         uint256 arrivalDateRet;

//         string consumerInfo;
//         uint256 purchaseDate;

//         State productState;











































  







}
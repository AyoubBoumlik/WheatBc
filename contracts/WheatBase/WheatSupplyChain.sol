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
        string retailerInfo;
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
  modifier onlyOwner() override {
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

// 1st step farm wheat

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

//2nd step harvest wheat;

function harvestWheatByFarmer (uint _upc, string memory _harvestDetail ) public onlyFarmer() farmedByFarmer(_upc) verifyCaller(products[_upc].ownerID) {


  products[_upc].productState = State.HarvestedByFarmer;
  
  products[_upc].harvestDetail = _harvestDetail ;
  products[_upc].harvestDate = block.timestamp ;


  emit HarvestedByFarmer(_upc);
}

//3rd step store the batch
function storeWheatByFarmer (uint _upc, string memory _storageInfoFarm) public 
onlyFarmer() harvestedByFarmer(_upc) verifyCaller(products[_upc].ownerID) {


  products[_upc].productState = State.StoredByFarmer;
  
  products[_upc].storageInfoFarm = _storageInfoFarm ;

  emit StoredByFarmer(_upc);
  
}

//4th step sell wheat by farmer

function sellWheatByFarmer ( uint _upc ) public
onlyFarmer() storedByFarmer(_upc) verifyCaller(products[_upc].ownerID) {

  products[_upc].productState = State.ForSaleByFarmer; 

  emit ForSaleByFarmer(_upc); 


}

//5th step purchase item by silo

function buyWheatBySilo ( uint _upc ) public 
onlySilo() forSaleByFarmer(_upc)  {

  

  products[_upc].ownerID = msg.sender;
  products[_upc].siloID = msg.sender;

  products[_upc].productState = State.BoughtBySilo;

  productHistory[_upc].FTS = block.number;

  emit BoughtBySilo(_upc);


}
// 6th step inspect by silo 

function inspectWheatBySilo (uint _upc, string memory _siloInfo, string memory _certificateOfInspection, string memory _processingInfoSilo ) public
onlySilo() boughtBySilo(_upc) verifyCaller(products[_upc].ownerID) {
  
  products[_upc].arrivalDateSilo = block.timestamp;
  products[_upc].siloInfo = _siloInfo;
  products[_upc].certificateOfInspection = _certificateOfInspection;
  products[_upc].processingInfoSilo = _processingInfoSilo;
  
  products[_upc].productState = State.InspectedBySilo; 

  emit InspectedBySilo(_upc);

}

//7th step store grain by silo

function storeGrainBySilo ( uint _upc, string memory _storageInfoBySilo) public 
onlySilo() inspectedBySilo(_upc) verifyCaller(products[_upc].ownerID) {

  products[_upc].storageInfoSilo =_storageInfoBySilo;
  
  products[_upc].productState = State.StoredBySilo; 
  
  emit StoredBySilo(_upc);

}


//8th step sell grain by silo

function sellGrainBySilo (uint _upc ) public 
onlySilo() storedBySilo(_upc) verifyCaller(products[_upc].ownerID)  {

  products[_upc].productState = State.ForSaleBySilo;

  emit ForSaleBySilo(_upc);

}

// 9th step buy by Mill

function buyGrainByMill ( uint _upc ) public
onlyMill() forSaleBySilo(_upc) {

  products[_upc].ownerID = msg.sender;
  products[_upc].millID = msg.sender;
  
  
  products[_upc].productState = State.BoughtByMill;

  emit BoughtByMill(_upc);

}

//10th step ship the grains to transporter 

function shipGrainToTransporter ( uint _upc ) public 
onlySilo() boughtByMill(_upc) verifyCaller(products[_upc].siloID) {

    products[_upc].productState = State.ShipBySilo;
    
    productHistory[_upc].STT = block.number;
    
    products[_upc].shippingDateSilo = block.timestamp;

    
    emit ShipBySilo(_upc);


}
//11th step export grain by transporter

function exportGrainByTrans ( uint _upc, string memory _transportInfo, string memory _transitDocument ) public 

onlyTransporter() shipBySilo(_upc) {

  products[_upc].transporterID = msg.sender;
  products[_upc].transportInfo = _transportInfo;
  products[_upc].transitDocument = _transitDocument;

  products[_upc].productState = State.ExportByTransporter;
  products[_upc].shippingtDateTrans = block.timestamp;

  productHistory[_upc].TTM = block.number;

  emit ExportByTransporter(_upc);
  
}

//12th recieve grain by mill

function recieveGrainByMill ( uint _upc, string memory _millInfo ) public 
onlyMill() exportByTransporter(_upc) verifyCaller(products[_upc].ownerID){

  products[_upc].productState = State.RecieveByMill;

  products[_upc].millInfo = _millInfo;
  products[_upc].arrivalDateMill = block.timestamp;
  
  emit RecieveByMill(_upc);

}

//13 processing grain by mill 
function processGrainByMill ( uint _upc, string memory _processingInfoMill) public 
onlyMill() recieveByMill(_upc) verifyCaller(products[_upc].ownerID) {

    products[_upc].productState = State.ProcessByMill;

    products[_upc].processingInfoMill = _processingInfoMill;

    emit ProcessByMill(_upc);

}

//14th packaging grains

function packagingGrainByMill ( uint _upc, string memory _packagingInfo, string memory _storageInfoMill, string memory _productDetailMill ) public 
onlyMill() processByMill(_upc) verifyCaller(products[_upc].ownerID) {

  products[_upc].productState = State.PackageByMill;

  products[_upc].packagingInfo = _packagingInfo ;
  products[_upc].storageInfoMill = _storageInfoMill ;
  products[_upc].productDetailMill = _productDetailMill;

  emit PackageByMill(_upc);
  

}

//15th forsale by mill 
function sellPackagedGrain (uint _upc ) public 
onlyMill() packageByMill(_upc) verifyCaller(products[_upc].ownerID)  {

  products[_upc].productState = State.ForSaleByMill;

  emit ForSaleByMill(_upc);

}

//16th buy by distributor

function buyPackagedWheatByDistributor ( uint _upc ) public 
onlyDistributor() forSaleByMill(_upc)  {

  

  products[_upc].ownerID = msg.sender;
  products[_upc].distributorID = msg.sender;

  products[_upc].productState = State.BoughtByDistributor;

  

  emit BoughtByDistributor(_upc);


}

//17th Ship by mill 

function shipPackagedWheatByMill ( uint _upc ) public 
onlyMill() boughtByDistributor(_upc) verifyCaller(products[_upc].millID){

  products[_upc].productState = State.ShipByMill;
  
  products[_upc].shippingDateMill = block.timestamp;

   emit ShipByMill(_upc);

}

// 18th recieved by distributor

function recievePackagedGrainByDistributor ( uint _upc, string memory _shipmentInfo )public 
onlyDistributor() shipByMill(_upc) verifyCaller(products[_upc].ownerID) {

products[_upc].productState = State.RecieveByDistributor ;
products[_upc].arrivalDateDist = block.timestamp;

products[_upc].shipmentInfo = _shipmentInfo ;
productHistory[_upc].MTD = block.number;

emit RecieveByDistributor(_upc);


}

//19th store by distributor

function storePackagedGrainByDistributor ( uint _upc , string memory _storageInfoDist) public onlyDistributor() recieveByDistributor(_upc) verifyCaller(products[_upc].ownerID) {
  products[_upc].productState = State.StoreByDistributor ;
  products[_upc].storageInfoDist = _storageInfoDist;

  emit StoreByDistributor(_upc);

}

//20th for sale by distributor 

function sellPackagedGrainByDistributor( uint _upc) public 
onlyDistributor() storeByDistributor(_upc) verifyCaller(products[_upc].ownerID) {

  products[_upc].productState = State.ForSaleByDistributor ;

  emit ForSaleByDistributor(_upc);

}

//21th buy by retailer

function buyPackagedGrainByDistributor( uint _upc  ) public 
onlyRetailer() forSaleByDistributor(_upc) {

  products[_upc].ownerID = msg.sender;
  products[_upc].retailerID = msg.sender;

  products[_upc].productState = State.BoughtByRetailer;

  emit BoughtByRetailer(_upc);

}

//22th ship by distributor

function shipPackagedGrainByDistributor ( uint _upc ) public 
onlyDistributor() boughtByRetailer(_upc) verifyCaller(products[_upc].distributorID){

  products[_upc].productState = State.ShipByDistributor;
  
  products[_upc].shippingDateDist = block.timestamp;

   emit ShipByDistributor(_upc);

}

//23th recieve products by retailer 

function recieveFinalProductByRetailer ( uint _upc, string memory _retailerInfo) public 
onlyRetailer() shipByDistributor(_upc) verifyCaller(products[_upc].ownerID)  {

 

  products[_upc].productState = State.RecieveByRetailer ;
  products[_upc].arrivalDateRet = block.timestamp;

  products[_upc].retailerInfo = _retailerInfo ;
  productHistory[_upc].DTR = block.number;

  emit RecieveByRetailer(_upc);


}

//24th stack products on shelves

function stackFinalProductOnShelvesByRetailer ( uint _upc, string memory _stackInfoRet) public 
onlyRetailer() recieveByRetailer(_upc) verifyCaller(products[_upc].ownerID) {
 
 
  products[_upc].productState = State.StackByRetailer ;
  products[_upc].stackInfoRet = _stackInfoRet;

  emit StackByRetailer(_upc);

}

//25th forsale by retailer

function finalProductForSaleByRetailer (uint _upc ) public 
onlyRetailer() stackByRetailer(_upc) verifyCaller(products[_upc].ownerID) {

  products[_upc].productState = State.ForSaleByRetailer ;

  emit ForSaleByRetailer(_upc);


}

//26th consumer buys final product 

function buyFinalProductByConsumer( uint _upc, string memory _consumerInfo ) public onlyConsumer() forSaleByRetailer(_upc)  {

  products[_upc].ownerID = msg.sender;
  products[_upc].consumerID = msg.sender;

  products[_upc].purchaseDate = block.timestamp;
  products[_upc].consumerInfo = _consumerInfo ;

  products[_upc].productState = State.BoughtByConsumer;
  productHistory[_upc].RTC = block.number;

  emit BoughtByConsumer(_upc);

}

function farmData( uint _upc ) public view returns (
        
        address ownerID,
        uint productID,

        uint productUPC,
        uint productBatchID,
        address farmID,
        string memory farmInfo,
        string memory harvestDetail,
        string memory storageInfoFarm,
        string memory farmChemicals,
        uint256 farmDate,
        uint256 harvestDate) {
          Product memory product = products[_upc];
          return ( 

            product.ownerID,
            product.productID,
            product.upc,
            product.batchID,
            product.farmID,
            product.farmInfo,
            product.harvestDetail,
            product.storageInfoFarm,
            product.farmChemicals,
            product.farmDate,
            product.harvestDate);
        }


function siloData ( uint _upc ) public view returns (

        address siloID,
        string memory siloInfo,
        string memory certificateOfInspection,
        string memory processingInfoSilo,
        string memory storageInfoSilo,
        uint256 arrivalDateSilo,
        uint256 shippingDateSilo
        ){

          Product memory product = products[_upc];
          
          return(
            product.siloID,
            product.siloInfo,
            product.certificateOfInspection,
            product.processingInfoSilo,
            product.storageInfoSilo,
            product.arrivalDateSilo,
            product.shippingDateSilo); }



function transporterData ( uint _upc ) public view returns (
        address transporterID,
        string memory transportInfo,
        string memory transitDocument,
        uint256 arrivalDateTrans,
        uint256 shippingtDateTrans

){
  Product memory product = products[_upc];
   return  (product.transporterID,
            product.transportInfo,
            product.transitDocument,
            product.arrivalDateTrans,
            product.shippingtDateTrans);
            }

  function millData ( uint _upc ) public view returns (

        address millID,
        string memory millInfo,
        string memory processingInfoMill,
        string memory storageInfoMill,
        string memory packagingInfo,
        string memory productDetailMill,
        uint256 arrivalDateMill,
        uint256 shippingDateMill
        ){

          Product memory product = products[_upc];
          
          return(
            product.millID,
            product.millInfo,
            product.processingInfoMill,
            product.storageInfoMill,
            product.packagingInfo,
            product.productDetailMill,
            product.arrivalDateMill,
            product.shippingDateMill); }


 function distributorData ( uint _upc ) public view returns (

         address distributorID,
        string memory storageInfoDist,
        string memory shipmentInfo,
        uint256 arrivalDateDist,
        uint256 shippingDateDist
        ){

          Product memory product = products[_upc];
          
          return(
            product.distributorID,
            product.storageInfoDist,
            product.shipmentInfo,
            product.arrivalDateDist,
            product.shippingDateDist); }

function retailerData ( uint _upc ) public view returns (

        address retailerID,
        string memory retailerInfo,
        string memory stackInfoRet,
        uint256 arrivalDateRet
        ){

          Product memory product = products[_upc];
          
          return(
            product.retailerID,
            product.retailerInfo,
            product.stackInfoRet,
            product.arrivalDateRet); }

function consumerData ( uint _upc ) public view returns (

        address consumerID,
        string memory consumerInfo,
        uint256 purchaseDate
        ){

          Product memory product = products[_upc];
          
          return(
            product.consumerID,
            product.consumerInfo,
            product.purchaseDate
            ); }



      
  




















// Product history
  function getProductHistory(uint _upc) public view returns
    (
        uint FTS,
        uint STT,
        uint TTM,
        uint MTD,
        uint DTR,
        uint RTC
    )
    {
      // Assign value to the parameters
      Txblocks memory txblock = productHistory[_upc];
      return
      (
        txblock.FTS,
        txblock.STT,
        txblock.TTM,
        txblock.MTD,
        txblock.DTR,
        txblock.RTC
      );

    }

   


  

    






 }
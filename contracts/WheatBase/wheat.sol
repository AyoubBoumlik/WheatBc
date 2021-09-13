// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract sol {

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

        string consumerInfo;
        uint256 purchaseDate;

    }

    struct Txblocks {

        uint FTS;
        uint STT;
        uint TTM;
        uint MTD;
        uint DTR;
        uint RTC;
        
    }

event FarmedByFarmer(uint upc);//1
event HarvestedByFarmer(uint upc);//2
event StoredByFarmer(uint upc);//3
event ForSaleByFarmer(uint upc);//4
event BoughtBySilo(uint upc);//5
event InspectedBySilo(uint upc);//6
event StoredBySilo(uint upc);//7
event ForSaleBySilo(uint upc);//8
event BoughtByMill(uint upc);//9
event ShipBySilo(uint upc);//10
event ExportByTransporter(uint upc);//11
event RecieveByMill(uint upc);//12
event ProcessByMill(uint upc);//13
event PackageByMill(uint upc);//14
event ForSaleByMill(uint upc);//15
event BoughtByDistributor(uint upc);//16
event ShipByMill(uint upc);//17
event RecieveByDistributor(uint upc);//18
event StoreByDistributor(uint upc);//19
event ForSaleByDistributor(uint upc);//20
event BoughtByRetailer(uint upc);//21
event ShipByDistributor(uint upc);//22
event RecieveByRetailer(uint upc);//23
event StackByRetailer(uint upc);//24
event ForSaleByRetailer(uint upc);//25
event BoughtByConsumer(uint upc);//26







}
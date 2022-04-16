import 'package:chotot_app/src/common/api_gateway.dart';
import 'package:chotot_app/src/models/address_model.dart';
import 'package:chotot_app/src/repositories/base_repo.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<http.Response> createPostCar(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required PostCarModelRequried postCarModel}) async {
    var body = {
      'typePost': onModel, //
      'type': "sale",
      'address': {
        'detail': postCarModel.address.detail,
        'village': postCarModel.address.village,
        'district': postCarModel.address.district,
        'province': postCarModel.address.province
      },
      'brand': postCarModel.brand,
      'yearOfManufacture': postCarModel.yearOfManufacture,
      'carGearbox': postCarModel.carGearbox,
      'fuel': postCarModel.fuel,
      'numberOfSeat': postCarModel.numberOfSeat,
      'color': postCarModel.color,
      'statusCar': postCarModel.statusCar,
      'numberOfKm': postCarModel.numberOfKm,
      'price': postCarModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostCar, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostMotorbike(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required PostMotorbikeModelRequired postMotorbikeModel}) async {
    var body = {
      'typePost': onModel, //
      'type': "sale",
      'address': {
        'detail': postMotorbikeModel.address.detail,
        'village': postMotorbikeModel.address.village,
        'district': postMotorbikeModel.address.district,
        'province': postMotorbikeModel.address.province
      },
      'brand': postMotorbikeModel.brand,
      'yearOfRegistration': postMotorbikeModel.yearOfRegistration,
      'typeMotorbike': postMotorbikeModel.typeMotorbike,
      'capacity': postMotorbikeModel.capacity,
      'statusMotorbike': postMotorbikeModel.statusMotorbike,
      'numberOfKm': postMotorbikeModel.numberOfKm,
      'price': postMotorbikeModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.craetePostMotorbike, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostElecticBicycle(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required PostElecticBicycleModelRequired postBycicleModel}) async {
    var body = {
      'typePost': onModel, //
      'type': "sale",
      'address': {
        'detail': postBycicleModel.address.detail,
        'village': postBycicleModel.address.village,
        'district': postBycicleModel.address.district,
        'province': postBycicleModel.address.province
      },
      'brand': postBycicleModel.brand,
      'typeBicycle': postBycicleModel.typeBicycle,
      'engine': postBycicleModel.engine,
      'statusBicycle': postBycicleModel.statusBicycle,
      'guarantee': postBycicleModel.guarantee,
      'price': postBycicleModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostElecticBicycle, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostLaptop(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required PostLaptopModelRequired postLaptopModel}) async {
    var body = {
      'typePost': onModel, //
      'type': "sale",
      'address': {
        'detail': postLaptopModel.address.detail,
        'village': postLaptopModel.address.village,
        'district': postLaptopModel.address.district,
        'province': postLaptopModel.address.province
      },
      'brand': postLaptopModel.brand,
      //'color': postLaptopModel.color,
      'microprocessor': postLaptopModel.microprocessor,
      'ram': postLaptopModel.ram,
      'hardDrive': postLaptopModel.hardDrive,
      'typeHardDrive': postLaptopModel.typeHardDrive,
      'graphicsCard': postLaptopModel.graphicsCard,
      'statusLaptop': postLaptopModel.statusLaptop,
      'guarantee': postLaptopModel.guarantee,
      'price': postLaptopModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostLaptop, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostPhone(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required PostPhoneModelRequired postPhoneModel}) async {
    var body = {
      'typePost': onModel, //
      'type': "sale",
      'address': {
        'detail': postPhoneModel.address.detail,
        'village': postPhoneModel.address.village,
        'district': postPhoneModel.address.district,
        'province': postPhoneModel.address.province
      },
      'brand': postPhoneModel.brand,
      'color': postPhoneModel.color,
      'ram': postPhoneModel.ram,
      'statusPhone': postPhoneModel.statusPhone,
      'price': postPhoneModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostPhone, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostApartment(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required String type,
      required PostApartmentModelRequired postApartmentModel}) async {
    var body = {
      'typePost': onModel, //
      'type': type,
      'address': {
        'detail': postApartmentModel.address.detail,
        'village': postApartmentModel.address.village,
        'district': postApartmentModel.address.district,
        'province': postApartmentModel.address.province
      },
      'nameOfBuilding': postApartmentModel.nameOfBuilding,
      'codeBuilding': postApartmentModel.codeBuilding,
      'block': postApartmentModel.block,
      'floor': postApartmentModel.floor,
      'typeBuilding': postApartmentModel.typeBuilding,
      'numberOfBedroom': postApartmentModel.numberOfBedroom,
      'numberOfBathroom': postApartmentModel.numberOfBathroom,
      'balconyDirection': postApartmentModel.balconyDirection,
      'doorDirection': postApartmentModel.doorDirection,
      'juridical': postApartmentModel.juridical,
      'InteriorCondition': postApartmentModel.interiorCondition,
      'area': postApartmentModel.area,
      'price': postApartmentModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostApartment, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostHouse(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required String type,
      required PostHouseModelRequired postHouseModel}) async {
    var body = {
      'typePost': onModel, //
      'type': type,
      'address': {
        'detail': postHouseModel.address.detail,
        'village': postHouseModel.address.village,
        'district': postHouseModel.address.district,
        'province': postHouseModel.address.province
      },
      'codeHouse': postHouseModel.codeHouse,
      'block': postHouseModel.block,
      'typeHouse': postHouseModel.typeHouse,
      'numberOfBedroom': postHouseModel.numberOfBedroom,
      'numberOfBathroom': postHouseModel.numberOfBathroom,
      'numberOfFloor': postHouseModel.numberOfFloor,
      'doorDirection': postHouseModel.doorDirection,
      'juridical': postHouseModel.juridical,

      'InteriorCondition': postHouseModel.interiorCondition,
      'area': postHouseModel.area,
      'height': postHouseModel.height,
      'width': postHouseModel.width,
      'price': postHouseModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostHouse, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostGround(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required String type,
      required PostGroundModelRequired postGroundModel}) async {
    var body = {
      'typePost': onModel, //
      'type': type,
      'address': {
        'detail': postGroundModel.address.detail,
        'village': postGroundModel.address.village,
        'district': postGroundModel.address.district,
        'province': postGroundModel.address.province
      },
      'typeGround': postGroundModel.typeGround,
      'groundDirection': postGroundModel.groundDirection,
      'juridical': postGroundModel.juridical,
      'area': postGroundModel.area,
      'height': postGroundModel.height,
      'width': postGroundModel.width,
      'price': postGroundModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostGround, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostOffice(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required String type,
      required PostOfficeModelRequired postOfficeModel}) async {
    var body = {
      'typePost': onModel, //
      'type': type,
      'address': {
        'detail': postOfficeModel.address.detail,
        'village': postOfficeModel.address.village,
        'district': postOfficeModel.address.district,
        'province': postOfficeModel.address.province
      },
      'nameOfBuilding': postOfficeModel.nameOfBuilding,
      'codeBuilding': postOfficeModel.codeBuilding,
      'block': postOfficeModel.block,
      'floor': postOfficeModel.floor,
      'typeOffice': postOfficeModel.typeOffice,
      'doorDirection': postOfficeModel.doorDirection,
      'juridical': postOfficeModel.juridical,
      'interiorCondition': postOfficeModel.interiorCondition,
      'area': postOfficeModel.area,
      'price': postOfficeModel.price,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostOffice, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }

  Future<http.Response> createPostMotelRoom(
      {required String onModel,
      required String title,
      required String content,
      required List<String> image,
      required String type,
      required PostMotelRoomModelRequired postMotelRoomModel}) async {
    var body = {
      'typePost': onModel, //
      'type': type,
      'address': {
        'detail': postMotelRoomModel.address.detail,
        'village': postMotelRoomModel.address.village,
        'district': postMotelRoomModel.address.district,
        'province': postMotelRoomModel.address.province
      },
      'interiorCondition': postMotelRoomModel.interiorCondition,
      'area': postMotelRoomModel.area,
      'price': postMotelRoomModel.price,
      'deposit': postMotelRoomModel.deposit,
      'title': title, //
      'content': content, //
      'image': image //
    };

    http.Response response =
        await BaseRepository().post(ApiGateway.createPostMotelRoom, body);

    var jsonData = response.body;
    print("data Response: " + jsonData);
    return response;
  }
}

class PostCarModelRequried {
  AddressModel address;
  String brand;
  int yearOfManufacture;
  String carGearbox;
  String fuel;
  int numberOfSeat;
  String color;
  String statusCar;
  int numberOfKm;
  int price;
  PostCarModelRequried(
      {required this.address,
      required this.brand,
      required this.yearOfManufacture,
      required this.carGearbox,
      required this.fuel,
      required this.numberOfSeat,
      required this.color,
      required this.statusCar,
      required this.numberOfKm,
      required this.price});
}

class PostMotorbikeModelRequired {
  AddressModel address;
  String brand;
  int yearOfRegistration;
  String typeMotorbike;
  String capacity;
  String statusMotorbike;
  int numberOfKm;
  int price;
  PostMotorbikeModelRequired(
      {required this.address,
      required this.brand,
      required this.yearOfRegistration,
      required this.typeMotorbike,
      required this.capacity,
      required this.statusMotorbike,
      required this.numberOfKm,
      required this.price});
}

class PostElecticBicycleModelRequired {
  AddressModel address;
  String brand;
  String typeBicycle;
  String engine;
  String statusBicycle;
  String guarantee;
  int price;
  PostElecticBicycleModelRequired(
      {required this.address,
      required this.brand,
      required this.typeBicycle,
      required this.engine,
      required this.statusBicycle,
      required this.guarantee,
      required this.price});
}

class PostLaptopModelRequired {
  AddressModel address;
  String brand;
  //String color;
  String microprocessor;
  String ram;
  String hardDrive;
  String typeHardDrive;
  String graphicsCard;
  String statusLaptop;
  String guarantee;
  int price;
  PostLaptopModelRequired(
      {required this.address,
      required this.brand,
      // required this.color,
      required this.microprocessor,
      required this.ram,
      required this.hardDrive,
      required this.typeHardDrive,
      required this.graphicsCard,
      required this.statusLaptop,
      required this.guarantee,
      required this.price});
}

class PostPhoneModelRequired {
  AddressModel address;
  String brand;
  String color;
  String ram;
  String statusPhone;
  int price;
  PostPhoneModelRequired(
      {required this.address,
      required this.brand,
      required this.color,
      required this.ram,
      required this.statusPhone,
      required this.price});
}

class PostApartmentModelRequired {
  String nameOfBuilding;
  AddressModel address;
  String codeBuilding;
  String block;
  int floor;
  String typeBuilding;
  String numberOfBedroom;
  String numberOfBathroom;
  String balconyDirection;
  String doorDirection;
  String juridical;
  String interiorCondition;
  double area;
  int price;
  PostApartmentModelRequired(
      {required this.nameOfBuilding,
      required this.address,
      required this.codeBuilding,
      required this.block,
      required this.floor,
      required this.typeBuilding,
      required this.numberOfBedroom,
      required this.numberOfBathroom,
      required this.balconyDirection,
      required this.doorDirection,
      required this.juridical,
      required this.interiorCondition,
      required this.area,
      required this.price});
}

class PostHouseModelRequired {
  AddressModel address;
  String codeHouse;
  String block;
  String typeHouse;
  String numberOfBedroom;
  String numberOfBathroom;
  String numberOfFloor;
  String doorDirection;
  String juridical;
  String interiorCondition;
  double area;
  double height;
  double width;
  int price;
  PostHouseModelRequired(
      {required this.address,
      required this.codeHouse,
      required this.block,
      required this.typeHouse,
      required this.numberOfBedroom,
      required this.numberOfBathroom,
      required this.numberOfFloor,
      required this.doorDirection,
      required this.juridical,
      required this.interiorCondition,
      required this.area,
      required this.height,
      required this.width,
      required this.price});
}

class PostGroundModelRequired {
  AddressModel address;
  String typeGround;
  String groundDirection;
  String juridical;
  double area;
  double height;
  double width;
  int price;
  PostGroundModelRequired(
      {required this.address,
      required this.typeGround,
      required this.groundDirection,
      required this.juridical,
      required this.area,
      required this.height,
      required this.width,
      required this.price});
}

class PostOfficeModelRequired {
  String nameOfBuilding;
  AddressModel address;
  String codeBuilding;
  String block;
  int floor;
  String typeOffice;
  String doorDirection;
  String juridical;
  String interiorCondition;
  double area;
  int price;
  PostOfficeModelRequired(
      {required this.nameOfBuilding,
      required this.address,
      required this.codeBuilding,
      required this.block,
      required this.floor,
      required this.typeOffice,
      required this.doorDirection,
      required this.juridical,
      required this.interiorCondition,
      required this.area,
      required this.price});
}

class PostMotelRoomModelRequired {
  AddressModel address;
  String interiorCondition;
  double area;
  int price;
  int deposit;
  PostMotelRoomModelRequired(
      {required this.address,
      required this.interiorCondition,
      required this.area,
      required this.price,
      required this.deposit});
}

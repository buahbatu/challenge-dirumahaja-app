import 'package:dirumahaja/core/result/base_response.dart';
import 'package:dirumahaja/core/tools/data_parser_factory.dart';

class EntityRegister {
  void register() {
    DataParserFactory.get().registerDecoder(BaseResponse.fromMap);
    // DataParserFactory.get().registerDecoder(AuthInfo.fromMap);
    // DataParserFactory.get().registerDecoder(Nurse.fromMap);
    // DataParserFactory.get().registerDecoder(Posyandu.fromMap);
    // DataParserFactory.get().registerDecoder(PersonMeta.fromMap);
    // DataParserFactory.get().registerDecoder(RecapList.fromMap);
    // DataParserFactory.get().registerDecoder(Recap.fromMap);
    // DataParserFactory.get().registerDecoder(RecapConfig.fromMap);
    // DataParserFactory.get().registerDecoder(RecapConfigList.fromMap);
    // DataParserFactory.get().registerDecoder(Immunization.fromMap);
    // DataParserFactory.get().registerDecoder(ImmunizationList.fromMap);
    // DataParserFactory.get().registerDecoder(ImmunizationConfig.fromMap);
    // DataParserFactory.get().registerDecoder(ImmunizationConfigList.fromMap);
    // DataParserFactory.get().registerDecoder(Article.fromMap);
    // DataParserFactory.get().registerDecoder(ArticleList.fromMap);
    // DataParserFactory.get().registerDecoder(Child.fromMap);
    // DataParserFactory.get().registerDecoder(ChildList.fromMap);
    // DataParserFactory.get().registerDecoder(ChildCheck.fromMap);
    // DataParserFactory.get().registerDecoder(ChildCheckList.fromMap);
    // DataParserFactory.get().registerDecoder(Mother.fromMap);
    // DataParserFactory.get().registerDecoder(MotherList.fromMap);
    // DataParserFactory.get().registerDecoder(Pregnancy.fromMap);
    // DataParserFactory.get().registerDecoder(PregnancyList.fromMap);
    // DataParserFactory.get().registerDecoder(PregnancyCheck.fromMap);
    // DataParserFactory.get().registerDecoder(PregnancyCheckList.fromMap);
  }

  // instance
  static EntityRegister _instance = EntityRegister();
  static EntityRegister get() => _instance;
}

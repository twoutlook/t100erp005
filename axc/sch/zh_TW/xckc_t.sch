/* 
================================================================================
檔案代號:xckc_t
檔案名稱:发出商品汇总统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xckc_t
(
xckcent       number(5)      ,/* 企业编号 */
xckccomp       varchar2(10)      ,/* 法人 */
xckcld       varchar2(5)      ,/* 账套 */
xckc001       number(5,0)      ,/* 年度 */
xckc002       number(5,0)      ,/* 期别 */
xckc003       varchar2(10)      ,/* 客户编号 */
xckc004       varchar2(40)      ,/* 产品编号 */
xckc005       varchar2(24)      ,/* 科目编号 */
xckc006       varchar2(10)      ,/* 库存单位 */
xckc007       number(20,6)      ,/* 期初数量 */
xckc008       number(20,6)      ,/* 期初金额 */
xckc009       number(20,6)      ,/* 本月出货数量 */
xckc010       number(20,6)      ,/* 本月出货金额 */
xckc011       number(20,6)      ,/* 本月转出数量 */
xckc012       number(20,6)      ,/* 本月转出金额 */
xckc013       number(20,6)      ,/* 期末数量 */
xckc014       number(20,6)      ,/* 期末金额 */
xckc015       number(20,6)      ,/* 币种二期初金额 */
xckc016       number(20,6)      ,/* 币种二本月出货金额 */
xckc017       number(20,6)      ,/* 币种二本月转出金额 */
xckc018       number(20,6)      ,/* 币种二期末金额 */
xckc019       number(20,6)      ,/* 币种三期初金额 */
xckc020       number(20,6)      ,/* 币种三本月出货金额 */
xckc021       number(20,6)      ,/* 币种三本月转出金额 */
xckc022       number(20,6)      ,/* 币种三期末金额 */
xckc023       varchar2(256)      ,/* 特性 */
xckc008a       number(20,6)      ,/* 期初金额-材料 */
xckc008b       number(20,6)      ,/* 期初金额-人工 */
xckc008c       number(20,6)      ,/* 期初金额-加工 */
xckc008d       number(20,6)      ,/* 期初金额-制费一 */
xckc008e       number(20,6)      ,/* 期初金额-制费二 */
xckc008f       number(20,6)      ,/* 期初金额-制费三 */
xckc008g       number(20,6)      ,/* 期初金额-制费四 */
xckc008h       number(20,6)      ,/* 期初金额-制费五 */
xckc010a       number(20,6)      ,/* 本月出货金额-材料 */
xckc010b       number(20,6)      ,/* 本月出货金额-人工 */
xckc010c       number(20,6)      ,/* 本月出货金额-加工 */
xckc010d       number(20,6)      ,/* 本月出货金额-制费一 */
xckc010e       number(20,6)      ,/* 本月出货金额-制费二 */
xckc010f       number(20,6)      ,/* 本月出货金额-制费三 */
xckc010g       number(20,6)      ,/* 本月出货金额-制费四 */
xckc010h       number(20,6)      ,/* 本月出货金额-制费五 */
xckc012a       number(20,6)      ,/* 本月转出金额-材料 */
xckc012b       number(20,6)      ,/* 本月转出金额-人工 */
xckc012c       number(20,6)      ,/* 本月转出金额-加工 */
xckc012d       number(20,6)      ,/* 本月转出金额-制费一 */
xckc012e       number(20,6)      ,/* 本月转出金额-制费二 */
xckc012f       number(20,6)      ,/* 本月转出金额-制费三 */
xckc012g       number(20,6)      ,/* 本月转出金额-制费四 */
xckc012h       number(20,6)      ,/* 本月转出金额-制费五 */
xckc014a       number(20,6)      ,/* 期末金额-材料 */
xckc014b       number(20,6)      ,/* 期末金额-人工 */
xckc014c       number(20,6)      ,/* 期末金额-加工 */
xckc014d       number(20,6)      ,/* 期末金额-制费一 */
xckc014e       number(20,6)      ,/* 期末金额-制费二 */
xckc014f       number(20,6)      ,/* 期末金额-制费三 */
xckc014g       number(20,6)      ,/* 期末金额-制费四 */
xckc014h       number(20,6)      ,/* 期末金额-制费五 */
xckc015a       number(20,6)      ,/* 币种二期初金额-材料 */
xckc015b       number(20,6)      ,/* 币种二期初金额-人工 */
xckc015c       number(20,6)      ,/* 币种二期初金额-加工 */
xckc015d       number(20,6)      ,/* 币种二期初金额-制费一 */
xckc015e       number(20,6)      ,/* 币种二期初金额-制费二 */
xckc015f       number(20,6)      ,/* 币种二期初金额-制费三 */
xckc015g       number(20,6)      ,/* 币种二期初金额-制费四 */
xckc015h       number(20,6)      ,/* 币种二期初金额-制费五 */
xckc016a       number(20,6)      ,/* 币种二本月出货金额-材料 */
xckc016b       number(20,6)      ,/* 币种二本月出货金额-人工 */
xckc016c       number(20,6)      ,/* 币种二本月出货金额-加工 */
xckc016d       number(20,6)      ,/* 币种二本月出货金额-制费一 */
xckc016e       number(20,6)      ,/* 币种二本月出货金额-制费二 */
xckc016f       number(20,6)      ,/* 币种二本月出货金额-制费三 */
xckc016g       number(20,6)      ,/* 币种二本月出货金额-制费四 */
xckc016h       number(20,6)      ,/* 币种二本月出货金额-制费五 */
xckc017a       number(20,6)      ,/* 币种二本月转出金额-材料 */
xckc017b       number(20,6)      ,/* 币种二本月转出金额-人工 */
xckc017c       number(20,6)      ,/* 币种二本月转出金额-加工 */
xckc017d       number(20,6)      ,/* 币种二本月转出金额-制费一 */
xckc017e       number(20,6)      ,/* 币种二本月转出金额-制费二 */
xckc017f       number(20,6)      ,/* 币种二本月转出金额-制费三 */
xckc017g       number(20,6)      ,/* 币种二本月转出金额-制费四 */
xckc017h       number(20,6)      ,/* 币种二本月转出金额-制费五 */
xckc018a       number(20,6)      ,/* 币种二期末金额-材料 */
xckc018b       number(20,6)      ,/* 币种二期末金额-人工 */
xckc018c       number(20,6)      ,/* 币种二期末金额-加工 */
xckc018d       number(20,6)      ,/* 币种二期末金额-制费一 */
xckc018e       number(20,6)      ,/* 币种二期末金额-制费二 */
xckc018f       number(20,6)      ,/* 币种二期末金额-制费三 */
xckc018g       number(20,6)      ,/* 币种二期末金额-制费四 */
xckc018h       number(20,6)      ,/* 币种二期末金额-制费五 */
xckc019a       number(20,6)      ,/* 币种三期初金额-材料 */
xckc019b       number(20,6)      ,/* 币种三期初金额-人工 */
xckc019c       number(20,6)      ,/* 币种三期初金额-加工 */
xckc019d       number(20,6)      ,/* 币种三期初金额-制费一 */
xckc019e       number(20,6)      ,/* 币种三期初金额-制费二 */
xckc019f       number(20,6)      ,/* 币种三期初金额-制费三 */
xckc019g       number(20,6)      ,/* 币种三期初金额-制费四 */
xckc019h       number(20,6)      ,/* 币种三期初金额-制费五 */
xckc020a       number(20,6)      ,/* 币种三本月出货金额-材料 */
xckc020b       number(20,6)      ,/* 币种三本月出货金额-人工 */
xckc020c       number(20,6)      ,/* 币种三本月出货金额-加工 */
xckc020d       number(20,6)      ,/* 币种三本月出货金额-制费一 */
xckc020e       number(20,6)      ,/* 币种三本月出货金额-制费二 */
xckc020f       number(20,6)      ,/* 币种三本月出货金额-制费三 */
xckc020g       number(20,6)      ,/* 币种三本月出货金额-制费四 */
xckc020h       number(20,6)      ,/* 币种三本月出货金额-制费五 */
xckc021a       number(20,6)      ,/* 币种三本月转出金额-材料 */
xckc021b       number(20,6)      ,/* 币种三本月转出金额-人工 */
xckc021c       number(20,6)      ,/* 币种三本月转出金额-加工 */
xckc021d       number(20,6)      ,/* 币种三本月转出金额-制费一 */
xckc021e       number(20,6)      ,/* 币种三本月转出金额-制费二 */
xckc021f       number(20,6)      ,/* 币种三本月转出金额-制费三 */
xckc021g       number(20,6)      ,/* 币种三本月转出金额-制费四 */
xckc021h       number(20,6)      ,/* 币种三本月转出金额-制费五 */
xckc022a       number(20,6)      ,/* 币种三期末金额-材料 */
xckc022b       number(20,6)      ,/* 币种三期末金额-人工 */
xckc022c       number(20,6)      ,/* 币种三期末金额-加工 */
xckc022d       number(20,6)      ,/* 币种三期末金额-制费一 */
xckc022e       number(20,6)      ,/* 币种三期末金额-制费二 */
xckc022f       number(20,6)      ,/* 币种三期末金额-制费三 */
xckc022g       number(20,6)      ,/* 币种三期末金额-制费四 */
xckc022h       number(20,6)      ,/* 币种三期末金额-制费五 */
xckc024       varchar2(20)      ,/* 出货单号 */
xckc025       number(5,0)      /* 出货项次 */
);
alter table xckc_t add constraint xckc_pk primary key (xckcent,xckccomp,xckcld,xckc001,xckc002,xckc003,xckc004,xckc023,xckc024,xckc025) enable validate;

create unique index xckc_pk on xckc_t (xckcent,xckccomp,xckcld,xckc001,xckc002,xckc003,xckc004,xckc023,xckc024,xckc025);

grant select on xckc_t to tiptop;
grant update on xckc_t to tiptop;
grant delete on xckc_t to tiptop;
grant insert on xckc_t to tiptop;

exit;

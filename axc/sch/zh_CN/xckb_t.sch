/* 
================================================================================
檔案代號:xckb_t
檔案名稱:发出商品统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xckb_t
(
xckbent       number(5)      ,/* 企業代碼 */
xckbcomp       varchar2(10)      ,/* 法人 */
xckbld       varchar2(5)      ,/* 帳別 */
xckb001       varchar2(1)      ,/* 來源 */
xckb002       number(5,0)      ,/* 方向 */
xckb003       varchar2(20)      ,/* 發票號碼 */
xckb004       varchar2(10)      ,/* 據點site */
xckb005       varchar2(20)      ,/* 出貨單號 */
xckb006       number(5,0)      ,/* 出貨項次 */
xckb007       number(5,0)      ,/* 年度 */
xckb008       number(5,0)      ,/* 期別 */
xckb009       varchar2(10)      ,/* 客戶編號 */
xckb010       varchar2(20)      ,/* 人員編號 */
xckb011       varchar2(10)      ,/* 部門編號 */
xckb012       varchar2(40)      ,/* 產品編號 */
xckb013       varchar2(10)      ,/* 銷售單位 */
xckb014       number(20,6)      ,/* 數量 */
xckb015       varchar2(10)      ,/* 倉庫編號 */
xckb016       varchar2(10)      ,/* 庫位編號 */
xckb017       varchar2(30)      ,/* 批號 */
xckb018       varchar2(40)      ,/* no use */
xckb019       varchar2(10)      ,/* 發票代碼 */
xckb020       varchar2(10)      ,/* 庫存單位 */
xckb021       number(20,6)      ,/* 庫存數量 */
xckb022       varchar2(24)      ,/* 科目編號 */
xckb023       varchar2(1)      ,/* 多角貿易否 */
xckb024       number(5,0)      ,/* 開票年度 */
xckb025       number(5,0)      ,/* 開票期別 */
xckb026       varchar2(10)      ,/* 幣種一 */
xckb027       number(20,6)      ,/* 金額 */
xckb028       varchar2(10)      ,/* 幣種二 */
xckb029       number(20,6)      ,/* 金額 */
xckb030       varchar2(10)      ,/* 幣種三 */
xckb031       number(20,6)      ,/* 金額 */
xckb032       number(20,6)      ,/* no use */
xckb033       number(20,6)      ,/* no use */
xckb034       number(20,6)      ,/* no use */
xckb035       varchar2(40)      ,/* no use */
xckb036       number(5,0)      ,/* 項序 */
xckb037       varchar2(256)      ,/* 特性 */
xckb101       number(20,6)      ,/* 幣種一成本單價 */
xckb101a       number(20,6)      ,/* 幣種一成本單價-材料 */
xckb101b       number(20,6)      ,/* 幣種一成本單價-人工 */
xckb101c       number(20,6)      ,/* 幣種一成本單價-加工 */
xckb101d       number(20,6)      ,/* 幣種一成本單價-制費一 */
xckb101e       number(20,6)      ,/* 幣種一成本單價-制費二 */
xckb101f       number(20,6)      ,/* 幣種一成本單價-制費三 */
xckb101g       number(20,6)      ,/* 幣種一成本單價-制費四 */
xckb101h       number(20,6)      ,/* 幣種一成本單價-制費五 */
xckb102       number(20,6)      ,/* 幣種一成本金額 */
xckb102a       number(20,6)      ,/* 幣種一成本金額-材料 */
xckb102b       number(20,6)      ,/* 幣種一成本金額-人工 */
xckb102c       number(20,6)      ,/* 幣種一成本金額-加工 */
xckb102d       number(20,6)      ,/* 幣種一成本金額-制費一 */
xckb102e       number(20,6)      ,/* 幣種一成本金額-制費二 */
xckb102f       number(20,6)      ,/* 幣種一成本金額-制費三 */
xckb102g       number(20,6)      ,/* 幣種一成本金額-制費四 */
xckb102h       number(20,6)      ,/* 幣種一成本金額-制費五 */
xckb111       number(20,6)      ,/* 幣種二成本單價 */
xckb111a       number(20,6)      ,/* 幣種二成本單價-材料 */
xckb111b       number(20,6)      ,/* 幣種二成本單價-人工 */
xckb111c       number(20,6)      ,/* 幣種二成本單價-加工 */
xckb111d       number(20,6)      ,/* 幣種二成本單價-制費一 */
xckb111e       number(20,6)      ,/* 幣種二成本單價-制費二 */
xckb111f       number(20,6)      ,/* 幣種二成本單價-制費三 */
xckb111g       number(20,6)      ,/* 幣種二成本單價-制費四 */
xckb111h       number(20,6)      ,/* 幣種二成本單價-制費五 */
xckb112       number(20,6)      ,/* 幣種二成本金額 */
xckb112a       number(20,6)      ,/* 幣種二成本金額-材料 */
xckb112b       number(20,6)      ,/* 幣種二成本金額-人工 */
xckb112c       number(20,6)      ,/* 幣種二成本金額-加工 */
xckb112d       number(20,6)      ,/* 幣種二成本金額-制費一 */
xckb112e       number(20,6)      ,/* 幣種二成本金額-制費二 */
xckb112f       number(20,6)      ,/* 幣種二成本金額-制費三 */
xckb112g       number(20,6)      ,/* 幣種二成本金額-制費四 */
xckb112h       number(20,6)      ,/* 幣種二成本金額-制費五 */
xckb121       number(20,6)      ,/* 幣種三成本單價 */
xckb121a       number(20,6)      ,/* 幣種三成本單價-材料 */
xckb121b       number(20,6)      ,/* 幣種三成本單價-人工 */
xckb121c       number(20,6)      ,/* 幣種三成本單價-加工 */
xckb121d       number(20,6)      ,/* 幣種三成本單價-制費一 */
xckb121e       number(20,6)      ,/* 幣種三成本單價-制費二 */
xckb121f       number(20,6)      ,/* 幣種三成本單價-制費三 */
xckb121g       number(20,6)      ,/* 幣種三成本單價-制費四 */
xckb121h       number(20,6)      ,/* 幣種三成本單價-制費五 */
xckb122       number(20,6)      ,/* 幣種三成本金額 */
xckb122a       number(20,6)      ,/* 幣種三成本金額-材料 */
xckb122b       number(20,6)      ,/* 幣種三成本金額-人工 */
xckb122c       number(20,6)      ,/* 幣種三成本金額-加工 */
xckb122d       number(20,6)      ,/* 幣種三成本金額-制費一 */
xckb122e       number(20,6)      ,/* 種三成本金額-制費二 */
xckb122f       number(20,6)      ,/* 幣種三成本金額-制費三 */
xckb122g       number(20,6)      ,/* 幣種三成本金額-制費四 */
xckb122h       number(20,6)      ,/* 幣種三成本金額-制費五 */
xckb038       varchar2(30)      /* 成本域 */
);
alter table xckb_t add constraint xckb_pk primary key (xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb005,xckb006,xckb007,xckb008,xckb036) enable validate;

create unique index xckb_pk on xckb_t (xckbent,xckbcomp,xckbld,xckb001,xckb002,xckb003,xckb005,xckb006,xckb007,xckb008,xckb036);

grant select on xckb_t to tiptop;
grant update on xckb_t to tiptop;
grant delete on xckb_t to tiptop;
grant insert on xckb_t to tiptop;

exit;

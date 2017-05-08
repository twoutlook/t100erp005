/* 
================================================================================
檔案代號:xred_t
檔案名稱:帳齡分析月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xred_t
(
xredent       number(5)      ,/* 企業代碼 */
xredcomp       varchar2(10)      ,/* 法人 */
xredsite       varchar2(10)      ,/* 帳務中心 */
xredld       varchar2(5)      ,/* 帳別 */
xred001       number(5,0)      ,/* 年度 */
xred002       number(5,0)      ,/* 期別 */
xred003       varchar2(10)      ,/* 來源模組 */
xred004       varchar2(10)      ,/* 帳款單性質 */
xred005       varchar2(20)      ,/* 單據號碼 */
xred006       number(10,0)      ,/* 項次 */
xred007       number(5,0)      ,/* 分期期別 */
xred008       date      ,/* 應兌現日 */
xred009       number(5,0)      ,/* 逾期天數 */
xred010       varchar2(10)      ,/* 信評等級 */
xred011       date      ,/* 帳齡起算日 */
xred012       number(20,6)      ,/* 壞帳提列比率 */
xred013       number(5,0)      ,/* 帳齡天數 */
xred014       varchar2(1)      ,/* 提列壞帳準備否 */
xred015       varchar2(20)      ,/* 壞帳提列傳票號碼 */
xred016       varchar2(10)      ,/* 來源組織 */
xred103       number(20,6)      ,/* 原幣扣抵金額 */
xred104       number(20,6)      ,/* 原幣壞帳提列數 */
xred105       number(20,6)      ,/* 原幣傳票提列數 */
xred113       number(20,6)      ,/* 本幣扣抵金額 */
xred114       number(20,6)      ,/* 本幣壞帳提列數 */
xred115       number(20,6)      ,/* 本幣傳票提列數 */
xred123       number(20,6)      ,/* 本位幣二扣抵金額 */
xred124       number(20,6)      ,/* 本位幣二壞帳提列數 */
xred125       number(20,6)      ,/* 本位幣二傳票提列數 */
xred133       number(20,6)      ,/* 本位幣三扣抵金額 */
xred134       number(20,6)      ,/* 本位幣三壞帳提列數 */
xred135       number(20,6)      ,/* 本位幣三傳票提列數 */
xredud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xredud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xredud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xredud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xredud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xredud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xredud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xredud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xredud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xredud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xredud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xredud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xredud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xredud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xredud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xredud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xredud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xredud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xredud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xredud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xredud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xredud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xredud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xredud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xredud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xredud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xredud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xredud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xredud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xredud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xred_t add constraint xred_pk primary key (xredent,xredld,xred001,xred002,xred003,xred005,xred006,xred007) enable validate;

create unique index xred_pk on xred_t (xredent,xredld,xred001,xred002,xred003,xred005,xred006,xred007);

grant select on xred_t to tiptop;
grant update on xred_t to tiptop;
grant delete on xred_t to tiptop;
grant insert on xred_t to tiptop;

exit;

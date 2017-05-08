/* 
================================================================================
檔案代號:xccg_t
檔案名稱:聯產品成本期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xccg_t
(
xccgent       number(5)      ,/* 企業編號 */
xccgcomp       varchar2(10)      ,/* 法人組織 */
xccgld       varchar2(5)      ,/* 帳套 */
xccg001       varchar2(1)      ,/* 帳套本位幣順序 */
xccg002       varchar2(30)      ,/* 成本域 */
xccg003       varchar2(10)      ,/* 成本計算類型 */
xccg004       number(5,0)      ,/* 年度 */
xccg005       number(5,0)      ,/* 期別 */
xccg006       varchar2(20)      ,/* 工單編號 */
xccg007       varchar2(40)      ,/* 聯產品料號 */
xccg008       varchar2(256)      ,/* 特性 */
xccg009       varchar2(30)      ,/* 批號 */
xccg010       varchar2(10)      ,/* 核算幣別 */
xccg101       number(20,6)      ,/* 上期結存數量 */
xccg102       number(20,6)      ,/* 上期結存金額 */
xccg102a       number(20,6)      ,/* 上期結存金額-材料 */
xccg102b       number(20,6)      ,/* 上期結存金額-人工 */
xccg102c       number(20,6)      ,/* 上期結存金額-加工 */
xccg102d       number(20,6)      ,/* 上期結存金額-制費一 */
xccg102e       number(20,6)      ,/* 上期結存金額-制費二 */
xccg102f       number(20,6)      ,/* 上期結存金額-制費三 */
xccg102g       number(20,6)      ,/* 上期結存金額-制費四 */
xccg102h       number(20,6)      ,/* 上期結存金額-制費五 */
xccg301       number(20,6)      ,/* 本期轉出數量 */
xccg302       number(20,6)      ,/* 本期轉出金額 */
xccg302a       number(20,6)      ,/* 本期轉出金額-材料 */
xccg302b       number(20,6)      ,/* 本期轉出金額-人工 */
xccg302c       number(20,6)      ,/* 本期轉出金額-加工 */
xccg302d       number(20,6)      ,/* 本期轉出金額-制費一 */
xccg302e       number(20,6)      ,/* 本期轉出金額-制費二 */
xccg302f       number(20,6)      ,/* 本期轉出金額-制費三 */
xccg302g       number(20,6)      ,/* 本期轉出金額-制費四 */
xccg302h       number(20,6)      ,/* 本期轉出金額-制費五 */
xccg901       number(20,6)      ,/* 期末結存數量 */
xccg902       number(20,6)      ,/* 期末結存金額 */
xccg902a       number(20,6)      ,/* 期末結存金額-材料 */
xccg902b       number(20,6)      ,/* 期末結存金額-人工 */
xccg902c       number(20,6)      ,/* 期末結存金額-加工 */
xccg902d       number(20,6)      ,/* 期末結存金額-制費一 */
xccg902e       number(20,6)      ,/* 期末結存金額-制費二 */
xccg902f       number(20,6)      ,/* 期末結存金額-制費三 */
xccg902g       number(20,6)      ,/* 期末結存金額-制費四 */
xccg902h       number(20,6)      ,/* 期末結存金額-制費五 */
xccgtime       timestamp(0)      ,/* 最近成本計算時間 */
xccgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccg_t add constraint xccg_pk primary key (xccgent,xccgld,xccg001,xccg002,xccg003,xccg004,xccg005,xccg006,xccg007,xccg008,xccg009) enable validate;

create unique index xccg_pk on xccg_t (xccgent,xccgld,xccg001,xccg002,xccg003,xccg004,xccg005,xccg006,xccg007,xccg008,xccg009);

grant select on xccg_t to tiptop;
grant update on xccg_t to tiptop;
grant delete on xccg_t to tiptop;
grant insert on xccg_t to tiptop;

exit;

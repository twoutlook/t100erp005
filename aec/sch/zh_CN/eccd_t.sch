/* 
================================================================================
檔案代號:eccd_t
檔案名稱:料件製程變更用料底稿損秏率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table eccd_t
(
eccdent       number(5)      ,/* 企業代碼 */
eccdsite       varchar2(10)      ,/* 營運據點 */
eccddocno       varchar2(20)      ,/* 申請單號 */
eccd001       varchar2(40)      ,/* 料件編號 */
eccd002       varchar2(10)      ,/* 製程編號 */
eccd003       number(10,0)      ,/* 製程項次 */
eccd004       number(10,0)      ,/* 項次 */
eccd005       number(20,6)      ,/* 起始數量 */
eccd006       number(20,6)      ,/* 截止數量 */
eccd007       number(20,6)      ,/* 變動損耗率 */
eccd008       number(20,6)      ,/* 固定損耗量 */
eccd900       number(10,0)      ,/* 變更序 */
eccd901       varchar2(1)      ,/* 變更類型 */
eccd902       date      ,/* 變更日期 */
eccd905       varchar2(10)      ,/* 變更原因 */
eccd906       varchar2(255)      ,/* 變更備註 */
eccdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
eccdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
eccdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
eccdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
eccdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
eccdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
eccdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
eccdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
eccdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
eccdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
eccdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
eccdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
eccdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
eccdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
eccdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
eccdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
eccdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
eccdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
eccdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
eccdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
eccdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
eccdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
eccdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
eccdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
eccdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
eccdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
eccdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
eccdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
eccdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
eccdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
eccdseq       number(10,0)      /* 項序 */
);
alter table eccd_t add constraint eccd_pk primary key (eccdent,eccdsite,eccddocno,eccd003,eccd004,eccd005,eccdseq) enable validate;

create unique index eccd_pk on eccd_t (eccdent,eccdsite,eccddocno,eccd003,eccd004,eccd005,eccdseq);

grant select on eccd_t to tiptop;
grant update on eccd_t to tiptop;
grant delete on eccd_t to tiptop;
grant insert on eccd_t to tiptop;

exit;

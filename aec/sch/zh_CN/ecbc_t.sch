/* 
================================================================================
檔案代號:ecbc_t
檔案名稱:料件製程用料底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbc_t
(
ecbcent       number(5)      ,/* 企業編號 */
ecbcsite       varchar2(10)      ,/* 營運據點 */
ecbc001       varchar2(40)      ,/* 製程料號 */
ecbc002       varchar2(10)      ,/* 製程編號 */
ecbc003       number(10,0)      ,/* 製程項次 */
ecbc004       number(10,0)      ,/* 項次 */
ecbc005       varchar2(40)      ,/* 元件料號 */
ecbc006       varchar2(10)      ,/* 部位 */
ecbc007       number(20,6)      ,/* 組成用量 */
ecbc008       number(20,6)      ,/* 主件底數 */
ecbc009       varchar2(10)      ,/* 用量單位 */
ecbc010       varchar2(10)      ,/* 損耗率型態 */
ecbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbc_t add constraint ecbc_pk primary key (ecbcent,ecbcsite,ecbc001,ecbc002,ecbc003,ecbc004) enable validate;

create unique index ecbc_pk on ecbc_t (ecbcent,ecbcsite,ecbc001,ecbc002,ecbc003,ecbc004);

grant select on ecbc_t to tiptop;
grant update on ecbc_t to tiptop;
grant delete on ecbc_t to tiptop;
grant insert on ecbc_t to tiptop;

exit;

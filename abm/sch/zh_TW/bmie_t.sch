/* 
================================================================================
檔案代號:bmie_t
檔案名稱:料號承認申請國際認證編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmie_t
(
bmieent       number(5)      ,/* 企業編號 */
bmiesite       varchar2(10)      ,/* 營運據點 */
bmiedocno       varchar2(20)      ,/* 料件承認申請單號 */
bmie001       varchar2(10)      ,/* 認證類型 */
bmie002       varchar2(40)      ,/* 認證編號 */
bmie003       varchar2(255)      ,/* 補充說明 */
bmieud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmieud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmieud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmieud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmieud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmieud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmieud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmieud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmieud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmieud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmieud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmieud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmieud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmieud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmieud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmieud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmieud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmieud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmieud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmieud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmieud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmieud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmieud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmieud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmieud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmieud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmieud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmieud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmieud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmieud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmie_t add constraint bmie_pk primary key (bmieent,bmiedocno,bmie001) enable validate;

create unique index bmie_pk on bmie_t (bmieent,bmiedocno,bmie001);

grant select on bmie_t to tiptop;
grant update on bmie_t to tiptop;
grant delete on bmie_t to tiptop;
grant insert on bmie_t to tiptop;

exit;

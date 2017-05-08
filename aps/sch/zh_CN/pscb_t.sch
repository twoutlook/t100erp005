/* 
================================================================================
檔案代號:pscb_t
檔案名稱:APS版本供需種類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pscb_t
(
pscbent       number(5)      ,/* 企業編號 */
pscbsite       varchar2(10)      ,/* 營運據點 */
pscb001       varchar2(10)      ,/* APS版本 */
pscb002       varchar2(10)      ,/* 供需來源 */
pscb003       varchar2(10)      ,/* 供需類型 */
pscb004       varchar2(1)      ,/* 未確認是否納入 */
pscbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pscbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pscbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pscbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pscbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pscbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pscbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pscbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pscbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pscbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pscbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pscbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pscbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pscbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pscbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pscbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pscbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pscbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pscbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pscbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pscbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pscbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pscbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pscbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pscbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pscbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pscbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pscbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pscbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pscbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pscb_t add constraint pscb_pk primary key (pscbent,pscbsite,pscb001,pscb002) enable validate;

create unique index pscb_pk on pscb_t (pscbent,pscbsite,pscb001,pscb002);

grant select on pscb_t to tiptop;
grant update on pscb_t to tiptop;
grant delete on pscb_t to tiptop;
grant insert on pscb_t to tiptop;

exit;

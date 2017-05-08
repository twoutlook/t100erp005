/* 
================================================================================
檔案代號:ecbf_t
檔案名稱:料件製程check in/out項目資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbf_t
(
ecbfent       number(5)      ,/* 企業編號 */
ecbfsite       varchar2(10)      ,/* 營運據點 */
ecbf001       varchar2(40)      ,/* 製程料號 */
ecbf002       varchar2(10)      ,/* 製程編號 */
ecbf003       number(10,0)      ,/* 製程項次 */
ecbfseq       number(10,0)      ,/* 項序 */
ecbf004       varchar2(1)      ,/* check in/check out */
ecbf005       varchar2(10)      ,/* 項目 */
ecbf006       varchar2(10)      ,/* 型態 */
ecbf007       number(15,3)      ,/* 下限 */
ecbf008       number(15,3)      ,/* 上限 */
ecbf009       varchar2(80)      ,/* 預設值 */
ecbf010       varchar2(1)      ,/* 必要 */
ecbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbf_t add constraint ecbf_pk primary key (ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq) enable validate;

create unique index ecbf_pk on ecbf_t (ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq);

grant select on ecbf_t to tiptop;
grant update on ecbf_t to tiptop;
grant delete on ecbf_t to tiptop;
grant insert on ecbf_t to tiptop;

exit;

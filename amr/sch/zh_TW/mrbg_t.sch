/* 
================================================================================
檔案代號:mrbg_t
檔案名稱:資源保險資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbg_t
(
mrbgent       number(5)      ,/* 企業編號 */
mrbgsite       varchar2(10)      ,/* 營運據點 */
mrbg001       varchar2(20)      ,/* 資源編號 */
mrbg002       number(10,0)      ,/* 項次 */
mrbg003       varchar2(80)      ,/* 保險內容 */
mrbg004       varchar2(10)      ,/* 保險廠商 */
mrbg005       varchar2(40)      ,/* 保險單號 */
mrbg006       date      ,/* 保險生效日 */
mrbg007       date      ,/* 保險到期日 */
mrbg008       varchar2(255)      ,/* 備註 */
mrbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbg_t add constraint mrbg_pk primary key (mrbgent,mrbgsite,mrbg001,mrbg002) enable validate;

create unique index mrbg_pk on mrbg_t (mrbgent,mrbgsite,mrbg001,mrbg002);

grant select on mrbg_t to tiptop;
grant update on mrbg_t to tiptop;
grant delete on mrbg_t to tiptop;
grant insert on mrbg_t to tiptop;

exit;

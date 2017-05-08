/* 
================================================================================
檔案代號:gzzb_t
檔案名稱:程式行業別群組設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzzb_t
(
gzzb001       varchar2(20)      ,/* 程式編號 */
gzzb002       varchar2(80)      ,/* 行業編號 */
gzzb003       varchar2(20)      ,/* 程式編號(標準) */
gzzbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzzb_t add constraint gzzb_pk primary key (gzzb001,gzzb002) enable validate;

create unique index gzzb_pk on gzzb_t (gzzb001,gzzb002);

grant select on gzzb_t to tiptop;
grant update on gzzb_t to tiptop;
grant delete on gzzb_t to tiptop;
grant insert on gzzb_t to tiptop;

exit;

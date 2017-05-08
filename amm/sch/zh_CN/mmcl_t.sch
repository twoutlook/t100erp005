/* 
================================================================================
檔案代號:mmcl_t
檔案名稱:換贈規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmcl_t
(
mmclent       number(5)      ,/* 企業編號 */
mmcl001       varchar2(30)      ,/* 活動規則編號 */
mmcl002       varchar2(10)      ,/* 卡種編號 */
mmcl003       number(10,0)      ,/* 換贈組別 */
mmcl004       number(20,6)      ,/* 換贈累計積點/消費額 */
mmcl005       number(5,0)      ,/* 兌換品種數 */
mmclstus       varchar2(1)      ,/* 有效 */
mmclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcl_t add constraint mmcl_pk primary key (mmclent,mmcl001,mmcl003) enable validate;

create unique index mmcl_pk on mmcl_t (mmclent,mmcl001,mmcl003);

grant select on mmcl_t to tiptop;
grant update on mmcl_t to tiptop;
grant delete on mmcl_t to tiptop;
grant insert on mmcl_t to tiptop;

exit;

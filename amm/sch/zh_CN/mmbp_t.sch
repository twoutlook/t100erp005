/* 
================================================================================
檔案代號:mmbp_t
檔案名稱:卡積點一般規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbp_t
(
mmbpent       number(5)      ,/* 企業編號 */
mmbpunit       varchar2(10)      ,/* 應用組織 */
mmbpsite       varchar2(10)      ,/* 營運據點 */
mmbpdocno       varchar2(30)      ,/* 單據編號 */
mmbp001       varchar2(30)      ,/* 活動規則編號 */
mmbp002       varchar2(10)      ,/* 卡種編號 */
mmbp003       varchar2(10)      ,/* 規則類型 */
mmbp004       varchar2(40)      ,/* 規則編碼 */
mmbp005       varchar2(1)      ,/* 基準單位 */
mmbp006       number(20,6)      ,/* 基準額滿 */
mmbp007       number(20,6)      ,/* 積點基準 */
mmbp008       number(15,3)      ,/* 單位積點 */
mmbpacti       varchar2(1)      ,/* 資料有效 */
mmbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbpud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmbp009       number(20,6)      ,/* 特價積點基準 */
mmbp010       number(15,3)      /* 特價單位積點 */
);
alter table mmbp_t add constraint mmbp_pk primary key (mmbpent,mmbpdocno,mmbp003,mmbp004) enable validate;

create unique index mmbp_pk on mmbp_t (mmbpent,mmbpdocno,mmbp003,mmbp004);

grant select on mmbp_t to tiptop;
grant update on mmbp_t to tiptop;
grant delete on mmbp_t to tiptop;
grant insert on mmbp_t to tiptop;

exit;

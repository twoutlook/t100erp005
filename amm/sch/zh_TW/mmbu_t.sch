/* 
================================================================================
檔案代號:mmbu_t
檔案名稱:卡積點一般規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbu_t
(
mmbuent       number(5)      ,/* 企業編號 */
mmbu001       varchar2(30)      ,/* 活動規則編號 */
mmbu002       varchar2(10)      ,/* 卡種編號 */
mmbu003       varchar2(10)      ,/* 規則類型 */
mmbu004       varchar2(40)      ,/* 規則編碼 */
mmbu005       varchar2(1)      ,/* 基準單位 */
mmbu006       number(20,6)      ,/* 基準額滿 */
mmbu007       number(20,6)      ,/* 積點基準 */
mmbu008       number(15,3)      ,/* 單位積點 */
mmbustus       varchar2(1)      ,/* 資料有效 */
mmbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbuud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmbu009       number(20,6)      ,/* 特價積點基準 */
mmbu010       number(15,3)      /* 特價單位積點 */
);
alter table mmbu_t add constraint mmbu_pk primary key (mmbuent,mmbu001,mmbu003,mmbu004) enable validate;

create unique index mmbu_pk on mmbu_t (mmbuent,mmbu001,mmbu003,mmbu004);

grant select on mmbu_t to tiptop;
grant update on mmbu_t to tiptop;
grant delete on mmbu_t to tiptop;
grant insert on mmbu_t to tiptop;

exit;

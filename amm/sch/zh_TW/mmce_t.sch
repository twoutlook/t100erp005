/* 
================================================================================
檔案代號:mmce_t
檔案名稱:卡儲值加值一般規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmce_t
(
mmceent       number(5)      ,/* 企業編號 */
mmce001       varchar2(30)      ,/* 活動規則編號 */
mmce002       varchar2(10)      ,/* 卡種編號 */
mmce003       varchar2(10)      ,/* 規則類型 */
mmce004       varchar2(40)      ,/* 規則編碼 */
mmce005       number(20,6)      ,/* 儲值基準額滿 */
mmce006       number(20,6)      ,/* 單位儲值基準 */
mmce007       number(20,6)      ,/* 單位加值金額 */
mmce008       number(5,0)      ,/* 儲值折扣率% */
mmcestus       varchar2(1)      ,/* 資料有效 */
mmceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmceud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmce009       varchar2(10)      /* 加值類型 */
);
alter table mmce_t add constraint mmce_pk primary key (mmceent,mmce001,mmce003,mmce004) enable validate;

create unique index mmce_pk on mmce_t (mmceent,mmce001,mmce003,mmce004);

grant select on mmce_t to tiptop;
grant update on mmce_t to tiptop;
grant delete on mmce_t to tiptop;
grant insert on mmce_t to tiptop;

exit;

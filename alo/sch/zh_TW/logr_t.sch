/* 
================================================================================
檔案代號:logr_t
檔案名稱:Rebuild重建歷程紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logr_t
(
logr001       varchar2(10)      ,/* 建置ID */
logr002       varchar2(1)      ,/* 建置項目 C, L ,F */
logr003       varchar2(10)      ,/* 建置模組 */
logr004       number(10,0)      ,/* 建置序號 */
logr005       varchar2(4000)      ,/* 錯誤訊息 */
logr006       varchar2(1)      ,/* 是否完成處理 */
logr007       varchar2(40)      ,/* 編譯日期 */
logr008       varchar2(20)      ,/* 程式代碼 */
logr009       varchar2(1)      ,/* 客戶編號 */
logrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table logr_t add constraint logr_pk primary key (logr001,logr002,logr003,logr004) enable validate;

create unique index logr_pk on logr_t (logr001,logr002,logr003,logr004);

grant select on logr_t to tiptop;
grant update on logr_t to tiptop;
grant delete on logr_t to tiptop;
grant insert on logr_t to tiptop;

exit;

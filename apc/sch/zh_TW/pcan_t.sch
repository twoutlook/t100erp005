/* 
================================================================================
檔案代號:pcan_t
檔案名稱:POSService錯誤日誌檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcan_t
(
pcanent       number(5)      ,/* 企業編號 */
pcanunit       varchar2(10)      ,/* 應用組織 */
pcansite       varchar2(10)      ,/* 營運組織 */
pcan001       varchar2(40)      ,/* 傳輸ID */
pcan002       varchar2(10)      ,/* 機號 */
pcan003       varchar2(40)      ,/* 服務名 */
pcan004       clob      ,/* 請求XML */
pcan005       clob      ,/* 迴應XML */
pcan006       varchar2(10)      ,/* 處理方式 */
pcan007       varchar2(10)      ,/* 服務狀態 */
pcan008       varchar2(10)      ,/* ERP錯誤代碼 */
pcan009       varchar2(40)      ,/* ERP錯誤資訊 */
pcan010       date      ,/* 請求日期 */
pcan011       varchar2(8)      ,/* 請求時間 */
pcan012       date      ,/* 回覆日期 */
pcan013       varchar2(8)      ,/* 回覆時間 */
pcan014       number(5,0)      ,/* 請求次數 */
pcanstus       varchar2(10)      ,/* 有效否 */
pcanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcan_t add constraint pcan_pk primary key (pcanent,pcansite,pcan001) enable validate;

create unique index pcan_pk on pcan_t (pcanent,pcansite,pcan001);

grant select on pcan_t to tiptop;
grant update on pcan_t to tiptop;
grant delete on pcan_t to tiptop;
grant insert on pcan_t to tiptop;

exit;

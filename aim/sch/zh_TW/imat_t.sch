/* 
================================================================================
檔案代號:imat_t
檔案名稱:條碼資訊主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imat_t
(
imatent       number(5)      ,/* 企業編號 */
imatsite       varchar2(10)      ,/* 營運據點 */
imat000       number(5,0)      ,/* 版次 */
imat001       varchar2(40)      ,/* 條碼編號 */
imat002       varchar2(40)      ,/* 料件編號 */
imat003       varchar2(20)      ,/* 來源作業 */
imat004       varchar2(20)      ,/* 來源單號 */
imat005       number(10,0)      ,/* 來源項次 */
imat006       number(10,0)      ,/* 來源項序 */
imat007       number(10,0)      ,/* 來源分批序 */
imat008       varchar2(256)      ,/* 產品特徵 */
imat009       number(5,0)      ,/* 條碼數量 */
imat010       number(5,0)      ,/* 列印次數 */
imat011       varchar2(40)      ,/* 原條碼編號 */
imat012       varchar2(10)      ,/* 料件單位 */
imatstus       varchar2(10)      ,/* 有效否 */
imatownid       varchar2(20)      ,/* 資料所有者 */
imatowndp       varchar2(10)      ,/* 資料所屬部門 */
imatcrtid       varchar2(20)      ,/* 資料建立者 */
imatcrtdp       varchar2(10)      ,/* 資料建立部門 */
imatcrtdt       timestamp(0)      ,/* 資料創建日 */
imatmodid       varchar2(20)      ,/* 資料修改者 */
imatmoddt       timestamp(0)      ,/* 最近修改日 */
imatcnfid       varchar2(20)      ,/* 資料確認者 */
imatcnfdt       timestamp(0)      ,/* 資料確認日 */
imatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imat_t add constraint imat_pk primary key (imatent,imat000,imat001,imat002,imat003,imat004,imat005,imat006,imat007,imat008) enable validate;

create unique index imat_pk on imat_t (imatent,imat000,imat001,imat002,imat003,imat004,imat005,imat006,imat007,imat008);

grant select on imat_t to tiptop;
grant update on imat_t to tiptop;
grant delete on imat_t to tiptop;
grant insert on imat_t to tiptop;

exit;

/* 
================================================================================
檔案代號:imav_t
檔案名稱:條碼資訊變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imav_t
(
imavent       number(5)      ,/* 企業編號 */
imavsite       varchar2(10)      ,/* 營運據點 */
imavdocno       varchar2(20)      ,/* 調整單號 */
imavdocdt       date      ,/* 調整日期 */
imav000       number(5,0)      ,/* 版次 */
imav001       varchar2(40)      ,/* 條碼編號 */
imav002       varchar2(40)      ,/* 料件編號 */
imav003       varchar2(20)      ,/* 來源作業 */
imav004       varchar2(20)      ,/* 來源單號 */
imav005       number(10,0)      ,/* 來源項次 */
imav006       number(10,0)      ,/* 來源項序 */
imav007       number(10,0)      ,/* 來源分批序 */
imav008       varchar2(256)      ,/* 產品特徵 */
imav009       number(5,0)      ,/* 條碼數量 */
imav011       varchar2(40)      ,/* 原條碼編號 */
imav012       varchar2(10)      ,/* 料件單位 */
imav013       varchar2(20)      ,/* 調整人員 */
imav014       varchar2(10)      ,/* 調整部門 */
imavstus       varchar2(10)      ,/* 狀態碼 */
imavcomp       varchar2(10)      ,/* 所屬法人 */
imavownid       varchar2(20)      ,/* 資料所有者 */
imavowndp       varchar2(10)      ,/* 資料所屬部門 */
imavcrtid       varchar2(20)      ,/* 資料建立者 */
imavcrtdp       varchar2(10)      ,/* 資料建立部門 */
imavcrtdt       timestamp(0)      ,/* 資料創建日 */
imavmodid       varchar2(20)      ,/* 資料修改者 */
imavmoddt       timestamp(0)      ,/* 最近修改日 */
imavcnfid       varchar2(20)      ,/* 資料確認者 */
imavcnfdt       timestamp(0)      ,/* 資料確認日 */
imavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imav_t add constraint imav_pk primary key (imavent,imavdocno) enable validate;

create unique index imav_pk on imav_t (imavent,imavdocno);

grant select on imav_t to tiptop;
grant update on imav_t to tiptop;
grant delete on imav_t to tiptop;
grant insert on imav_t to tiptop;

exit;

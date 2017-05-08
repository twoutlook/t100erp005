/* 
================================================================================
檔案代號:imab_t
檔案名稱:額外料件品名規格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imab_t
(
imabent       number(5)      ,/* 企業編號 */
imab001       varchar2(40)      ,/* 料件編號 */
imab002       varchar2(10)      ,/* 額外品名規格類型 */
imab003       number(10,0)      ,/* 行序 */
imab004       varchar2(10)      ,/* 分類 */
imab005       varchar2(4000)      ,/* 說明 */
imabownid       varchar2(20)      ,/* 資料所有者 */
imabowndp       varchar2(10)      ,/* 資料所屬部門 */
imabcrtid       varchar2(20)      ,/* 資料建立者 */
imabcrtdp       varchar2(10)      ,/* 資料建立部門 */
imabcrtdt       timestamp(0)      ,/* 資料創建日 */
imabmodid       varchar2(20)      ,/* 資料修改者 */
imabmoddt       timestamp(0)      ,/* 最近修改日 */
imabcnfid       varchar2(20)      ,/* 資料確認者 */
imabcnfdt       timestamp(0)      ,/* 資料確認日 */
imabstus       varchar2(10)      ,/* 狀態碼 */
imabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imab_t add constraint imab_pk primary key (imabent,imab001,imab002,imab003) enable validate;

create unique index imab_pk on imab_t (imabent,imab001,imab002,imab003);

grant select on imab_t to tiptop;
grant update on imab_t to tiptop;
grant delete on imab_t to tiptop;
grant insert on imab_t to tiptop;

exit;

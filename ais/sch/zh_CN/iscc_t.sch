/* 
================================================================================
檔案代號:iscc_t
檔案名稱:固資退稅主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table iscc_t
(
isccent       number(5)      ,/* 企業代碼 */
iscccomp       varchar2(10)      ,/* 法人 */
isccsite       varchar2(10)      ,/* 申報單位 */
isccseq       number(10,0)      ,/* 序號 */
iscc001       number(5,0)      ,/* 申報年度 */
iscc002       number(5,0)      ,/* 申報月份 */
iscc003       varchar2(10)      ,/* 申報格式 */
iscc004       varchar2(20)      ,/* 發票代碼 */
iscc005       varchar2(20)      ,/* 發票號碼 */
iscc006       date      ,/* 開立年月日 */
iscc007       varchar2(20)      ,/* 海關代徵營業稅繳納證號碼 */
iscc008       varchar2(80)      ,/* 內容摘要名稱 */
iscc009       number(20,6)      ,/* 內容摘要數量 */
iscc010       varchar2(500)      ,/* 用途 */
iscc103       number(20,6)      ,/* 內容摘要未稅金額 */
iscc104       number(20,6)      ,/* 內容摘要稅額 */
isccownid       varchar2(20)      ,/* 資料所有者 */
isccowndp       varchar2(10)      ,/* 資料所屬部門 */
iscccrtid       varchar2(20)      ,/* 資料建立者 */
iscccrtdp       varchar2(10)      ,/* 資料建立部門 */
iscccrtdt       timestamp(0)      ,/* 資料創建日 */
isccmodid       varchar2(20)      ,/* 資料修改者 */
isccmoddt       timestamp(0)      ,/* 最近修改日 */
iscccnfid       varchar2(20)      ,/* 資料確認者 */
iscccnfdt       timestamp(0)      ,/* 資料確認日 */
isccstus       varchar2(10)      ,/* 狀態碼 */
isccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table iscc_t add constraint iscc_pk primary key (isccent,isccsite,isccseq,iscc001,iscc002) enable validate;

create unique index iscc_pk on iscc_t (isccent,isccsite,isccseq,iscc001,iscc002);

grant select on iscc_t to tiptop;
grant update on iscc_t to tiptop;
grant delete on iscc_t to tiptop;
grant insert on iscc_t to tiptop;

exit;

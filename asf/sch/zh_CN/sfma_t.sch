/* 
================================================================================
檔案代號:sfma_t
檔案名稱:耗料盤存倒扣分攤單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfma_t
(
sfmaent       number(5)      ,/* 企業編號 */
sfmasite       varchar2(10)      ,/* 營運據點 */
sfmadocno       varchar2(20)      ,/* 盤點單號 */
sfmadocdt       date      ,/* 盤點日期 */
sfma001       varchar2(10)      ,/* 分攤方式 */
sfma002       date      ,/* 起始日期 */
sfma003       date      ,/* 截止日期 */
sfma004       varchar2(10)      ,/* 庫位 */
sfma005       varchar2(10)      ,/* 儲位 */
sfmaownid       varchar2(20)      ,/* 資料所有者 */
sfmaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfmacrtid       varchar2(20)      ,/* 資料建立者 */
sfmacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfmacrtdt       timestamp(0)      ,/* 資料創建日 */
sfmamodid       varchar2(20)      ,/* 資料修改者 */
sfmamoddt       timestamp(0)      ,/* 最近修改日 */
sfmacnfid       varchar2(20)      ,/* 資料確認者 */
sfmacnfdt       timestamp(0)      ,/* 資料確認日 */
sfmapstid       varchar2(20)      ,/* 資料過帳者 */
sfmapstdt       timestamp(0)      ,/* 資料過帳日 */
sfmastus       varchar2(10)      ,/* 狀態碼 */
sfmaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfmaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfmaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfmaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfmaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfmaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfmaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfmaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfmaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfmaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfmaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfmaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfmaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfmaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfmaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfmaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfmaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfmaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfmaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfmaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfmaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfmaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfmaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfmaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfmaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfmaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfmaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfmaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfmaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfmaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfma_t add constraint sfma_pk primary key (sfmaent,sfmadocno) enable validate;

create unique index sfma_pk on sfma_t (sfmaent,sfmadocno);

grant select on sfma_t to tiptop;
grant update on sfma_t to tiptop;
grant delete on sfma_t to tiptop;
grant insert on sfma_t to tiptop;

exit;

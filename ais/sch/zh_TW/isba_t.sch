/* 
================================================================================
檔案代號:isba_t
檔案名稱:發票收款主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table isba_t
(
isbaent       number(5)      ,/* 企業編碼 */
isbacomp       varchar2(10)      ,/* 法人 */
isbadocno       varchar2(20)      ,/* 收款單號 */
isbadocdt       date      ,/* 收款日期 */
isba001       varchar2(20)      ,/* 收款人員 */
isba002       varchar2(10)      ,/* 收款部門 */
isba003       varchar2(10)      ,/* 收款對象 */
isbastus       varchar2(1)      ,/* 確認碼 */
isbaownid       varchar2(20)      ,/* 資料所有者 */
isbaowndp       varchar2(10)      ,/* 資料所屬部門 */
isbacrtid       varchar2(20)      ,/* 資料建立者 */
isbacrtdp       varchar2(10)      ,/* 資料建立部門 */
isbacrtdt       timestamp(0)      ,/* 資料創建日 */
isbamodid       varchar2(20)      ,/* 資料修改者 */
isbamoddt       timestamp(0)      ,/* 最近修改日 */
isbacnfid       varchar2(20)      ,/* 資料確認者 */
isbacnfdt       timestamp(0)      ,/* 資料確認日 */
isbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isba_t add constraint isba_pk primary key (isbaent,isbacomp,isbadocno) enable validate;

create unique index isba_pk on isba_t (isbaent,isbacomp,isbadocno);

grant select on isba_t to tiptop;
grant update on isba_t to tiptop;
grant delete on isba_t to tiptop;
grant insert on isba_t to tiptop;

exit;

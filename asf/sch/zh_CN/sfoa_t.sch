/* 
================================================================================
檔案代號:sfoa_t
檔案名稱:工單製程變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfoa_t
(
sfoaent       number(5)      ,/* 企業代碼 */
sfoasite       varchar2(10)      ,/* 營運據點 */
sfoadocno       varchar2(20)      ,/* 工單單號 */
sfoa001       number(10,0)      ,/* RUN CARD編號 */
sfoa002       number(10,0)      ,/* 變更版本 */
sfoa003       number(20,6)      ,/* 生產數量 */
sfoa004       number(20,6)      ,/* 完工數量 */
sfoa900       number(10,0)      ,/* 變更序 */
sfoa901       varchar2(1)      ,/* 變更類型 */
sfoa902       date      ,/* 變更日期 */
sfoa905       varchar2(10)      ,/* 變更理由 */
sfoa906       varchar2(255)      ,/* 變更備註 */
sfoaownid       varchar2(20)      ,/* 資料所有者 */
sfoaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfoacrtid       varchar2(20)      ,/* 資料建立者 */
sfoacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfoacrtdt       timestamp(0)      ,/* 資料創建日 */
sfoamodid       varchar2(20)      ,/* 資料修改者 */
sfoamoddt       timestamp(0)      ,/* 最近修改日 */
sfoacnfid       varchar2(20)      ,/* 資料確認者 */
sfoacnfdt       timestamp(0)      ,/* 資料確認日 */
sfoapstid       varchar2(20)      ,/* 資料過帳者 */
sfoapstdt       timestamp(0)      ,/* 資料過帳日 */
sfoastus       varchar2(10)      ,/* 狀態碼 */
sfoa005       varchar2(1)      ,/* RUN CARD類型 */
sfoaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfoaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfoaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfoaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfoaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfoaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfoaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfoaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfoaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfoaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfoaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfoaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfoaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfoaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfoaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfoaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfoaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfoaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfoaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfoaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfoaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfoaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfoaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfoaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfoaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfoaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfoaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfoaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfoaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfoaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfoa_t add constraint sfoa_pk primary key (sfoaent,sfoadocno,sfoa001,sfoa900) enable validate;

create unique index sfoa_pk on sfoa_t (sfoaent,sfoadocno,sfoa001,sfoa900);

grant select on sfoa_t to tiptop;
grant update on sfoa_t to tiptop;
grant delete on sfoa_t to tiptop;
grant insert on sfoa_t to tiptop;

exit;

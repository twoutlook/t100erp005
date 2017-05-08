/* 
================================================================================
檔案代號:inqa_t
檔案名稱:產品組合拆解單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inqa_t
(
inqaent       number(5)      ,/* 企業編號 */
inqasite       varchar2(10)      ,/* 營運據點 */
inqaunit       varchar2(10)      ,/* 應用組織 */
inqadocno       varchar2(20)      ,/* 單據編號 */
inqadocdt       date      ,/* 單據日期 */
inqa000       varchar2(1)      ,/* 單據性質 */
inqa001       date      ,/* 過帳日期 */
inqa002       varchar2(20)      ,/* 申請人員 */
inqa003       varchar2(10)      ,/* 申請部門 */
inqa004       varchar2(10)      ,/* 理由碼 */
inqa005       varchar2(20)      ,/* 對應雜收單號 */
inqa006       varchar2(20)      ,/* 對應雜發單號 */
inqa007       varchar2(255)      ,/* 備註 */
inqaownid       varchar2(20)      ,/* 資料所有者 */
inqaowndp       varchar2(10)      ,/* 資料所屬部門 */
inqacrtid       varchar2(20)      ,/* 資料建立者 */
inqacrtdp       varchar2(10)      ,/* 資料建立部門 */
inqacrtdt       timestamp(0)      ,/* 資料創建日 */
inqamodid       varchar2(20)      ,/* 資料修改者 */
inqamoddt       timestamp(0)      ,/* 最近修改日 */
inqacnfid       varchar2(20)      ,/* 資料確認者 */
inqacnfdt       timestamp(0)      ,/* 資料確認日 */
inqapstid       varchar2(20)      ,/* 資料過帳者 */
inqapstdt       timestamp(0)      ,/* 資料過帳日 */
inqastus       varchar2(10)      ,/* 狀態碼 */
inqaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inqaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inqaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inqaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inqaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inqaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inqaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inqaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inqaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inqaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inqaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inqaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inqaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inqaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inqaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inqaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inqaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inqaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inqaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inqaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inqaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inqaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inqaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inqaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inqaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inqaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inqaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inqaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inqaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inqaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inqa_t add constraint inqa_pk primary key (inqaent,inqadocno) enable validate;

create unique index inqa_pk on inqa_t (inqaent,inqadocno);

grant select on inqa_t to tiptop;
grant update on inqa_t to tiptop;
grant delete on inqa_t to tiptop;
grant insert on inqa_t to tiptop;

exit;

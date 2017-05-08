/* 
================================================================================
檔案代號:fmmw_t
檔案名稱:收息賬務單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmw_t
(
fmmwent       number(5)      ,/* 企業代碼 */
fmmwdocno       varchar2(20)      ,/* 單號 */
fmmwcomp       varchar2(10)      ,/* 法人 */
fmmwsite       varchar2(10)      ,/* 營運據點 */
fmmwdocdt       date      ,/* 單據日期 */
fmmw001       varchar2(5)      ,/* 帳套 */
fmmw002       number(5,0)      ,/* 年度 */
fmmw003       number(5,0)      ,/* 期別 */
fmmw004       varchar2(20)      ,/* 憑證號碼 */
fmmw005       varchar2(20)      ,/* 賬務人員 */
fmmwownid       varchar2(20)      ,/* 資料所有者 */
fmmwowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmwcrtid       varchar2(20)      ,/* 資料建立者 */
fmmwcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmwcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmwmodid       varchar2(20)      ,/* 資料修改者 */
fmmwmoddt       timestamp(0)      ,/* 最近修改日 */
fmmwcnfid       varchar2(20)      ,/* 資料確認者 */
fmmwcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmwpstid       varchar2(20)      ,/* 資料過帳者 */
fmmwpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmwstus       varchar2(10)      ,/* 狀態碼 */
fmmwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmw_t add constraint fmmw_pk primary key (fmmwent,fmmwdocno) enable validate;

create unique index fmmw_pk on fmmw_t (fmmwent,fmmwdocno);

grant select on fmmw_t to tiptop;
grant update on fmmw_t to tiptop;
grant delete on fmmw_t to tiptop;
grant insert on fmmw_t to tiptop;

exit;

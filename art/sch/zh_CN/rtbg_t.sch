/* 
================================================================================
檔案代號:rtbg_t
檔案名稱:商品主供應商調整單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtbg_t
(
rtbgent       number(5)      ,/* 企業代碼 */
rtbgsite       varchar2(10)      ,/* 營運據點 */
rtbgunit       varchar2(10)      ,/* 制定組織 */
rtbgdocdt       date      ,/* 單據日期 */
rtbgdocno       varchar2(20)      ,/* 單號 */
rtbg001       varchar2(20)      ,/* 業務人員 */
rtbg002       varchar2(10)      ,/* 業務部門 */
rtbg003       varchar2(255)      ,/* 備註 */
rtbgownid       varchar2(20)      ,/* 資料所有者 */
rtbgowndp       varchar2(10)      ,/* 資料所屬部門 */
rtbgcrtid       varchar2(20)      ,/* 資料建立者 */
rtbgcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtbgcrtdt       timestamp(0)      ,/* 資料創建日 */
rtbgmodid       varchar2(20)      ,/* 資料修改者 */
rtbgmoddt       timestamp(0)      ,/* 最近修改日 */
rtbgcnfid       varchar2(20)      ,/* 資料確認者 */
rtbgcnfdt       timestamp(0)      ,/* 資料確認日 */
rtbgstus       varchar2(10)      ,/* 狀態碼 */
rtbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtbg_t add constraint rtbg_pk primary key (rtbgent,rtbgdocno) enable validate;

create unique index rtbg_pk on rtbg_t (rtbgent,rtbgdocno);

grant select on rtbg_t to tiptop;
grant update on rtbg_t to tiptop;
grant delete on rtbg_t to tiptop;
grant insert on rtbg_t to tiptop;

exit;

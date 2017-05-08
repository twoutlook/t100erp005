/* 
================================================================================
檔案代號:rtdg_t
檔案名稱:供應商生命週期調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtdg_t
(
rtdgent       number(5)      ,/* 企業編號 */
rtdgsite       varchar2(10)      ,/* 營運組織 */
rtdgunit       varchar2(10)      ,/* 應用組織 */
rtdgdocno       varchar2(20)      ,/* 單據編號 */
rtdgdocdt       date      ,/* 單據日期 */
rtdg001       varchar2(20)      ,/* 業務人員 */
rtdg002       varchar2(10)      ,/* 部門 */
rtdg003       varchar2(80)      ,/* 備註 */
rtdgstus       varchar2(10)      ,/* 狀態 */
rtdgownid       varchar2(20)      ,/* 資料所有者 */
rtdgowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdgcrtid       varchar2(20)      ,/* 資料建立者 */
rtdgcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdgcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdgmodid       varchar2(20)      ,/* 資料修改者 */
rtdgmoddt       timestamp(0)      ,/* 最近修改日 */
rtdgcnfid       varchar2(20)      ,/* 資料確認者 */
rtdgcnfdt       timestamp(0)      ,/* 資料確認日 */
rtdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdg_t add constraint rtdg_pk primary key (rtdgent,rtdgdocno) enable validate;

create unique index rtdg_pk on rtdg_t (rtdgent,rtdgdocno);

grant select on rtdg_t to tiptop;
grant update on rtdg_t to tiptop;
grant delete on rtdg_t to tiptop;
grant insert on rtdg_t to tiptop;

exit;

/* 
================================================================================
檔案代號:stdg_t
檔案名稱:內部結算單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stdg_t
(
stdgent       number(5)      ,/* 企業編號 */
stdgunit       varchar2(10)      ,/* 應用組織 */
stdgsite       varchar2(10)      ,/* 營運據點 */
stdgdocno       varchar2(20)      ,/* 單據編號 */
stdgdocdt       date      ,/* 單據日期 */
stdg001       varchar2(10)      ,/* 結算對象1 */
stdg002       varchar2(10)      ,/* 結算對象2 */
stdg003       number(10,0)      ,/* 結算會計期 */
stdg004       date      ,/* 起始日期 */
stdg005       date      ,/* 截止日期 */
stdg006       varchar2(20)      ,/* 結算人員 */
stdg007       varchar2(10)      ,/* 結算部門 */
stdgstus       varchar2(10)      ,/* 狀態碼 */
stdgownid       varchar2(20)      ,/* 資料所有者 */
stdgowndp       varchar2(10)      ,/* 資料所屬部門 */
stdgcrtid       varchar2(20)      ,/* 資料建立者 */
stdgcrtdp       varchar2(10)      ,/* 資料建立部門 */
stdgcrtdt       timestamp(0)      ,/* 資料創建日 */
stdgmodid       varchar2(20)      ,/* 資料修改者 */
stdgmoddt       timestamp(0)      ,/* 最近修改日 */
stdgcnfid       varchar2(20)      ,/* 資料確認者 */
stdgcnfdt       timestamp(0)      ,/* 資料確認日 */
stdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdg_t add constraint stdg_pk primary key (stdgent,stdgdocno) enable validate;

create unique index stdg_pk on stdg_t (stdgent,stdgdocno);

grant select on stdg_t to tiptop;
grant update on stdg_t to tiptop;
grant delete on stdg_t to tiptop;
grant insert on stdg_t to tiptop;

exit;

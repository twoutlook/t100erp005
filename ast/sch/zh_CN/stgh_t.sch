/* 
================================================================================
檔案代號:stgh_t
檔案名稱:專櫃成本調整單單頭交易檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stgh_t
(
stghent       number(5)      ,/* 企業編號 */
stghsite       varchar2(10)      ,/* 營運組織 */
stghunit       varchar2(10)      ,/* 應用組織 */
stghdocno       varchar2(20)      ,/* 單據編號 */
stghdocdt       date      ,/* 單據日期 */
stgh000       varchar2(10)      ,/* 調整類型 */
stgh001       date      ,/* 起始日期 */
stgh002       date      ,/* 截止日期 */
stghstus       varchar2(1)      ,/* 狀態碼 */
stghownid       varchar2(20)      ,/* 資料所有者 */
stghowndp       varchar2(10)      ,/* 資料所屬部門 */
stghcrtid       varchar2(20)      ,/* 資料建立者 */
stghcrtdp       varchar2(10)      ,/* 資料建立部門 */
stghcrtdt       timestamp(0)      ,/* 資料創建日 */
stghmodid       varchar2(20)      ,/* 資料修改者 */
stghmoddt       timestamp(0)      ,/* 最近修改日 */
stghcnfid       varchar2(20)      ,/* 資料確認者 */
stghcnfdt       timestamp(0)      ,/* 資料確認日 */
stghud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stghud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stghud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stghud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stghud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stghud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stghud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stghud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stghud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stghud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stghud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stghud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stghud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stghud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stghud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stghud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stghud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stghud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stghud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stghud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stghud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stghud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stghud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stghud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stghud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stghud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stghud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stghud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stghud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stghud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stgh_t add constraint stgh_pk primary key (stghent,stghdocno) enable validate;

create unique index stgh_pk on stgh_t (stghent,stghdocno);

grant select on stgh_t to tiptop;
grant update on stgh_t to tiptop;
grant delete on stgh_t to tiptop;
grant insert on stgh_t to tiptop;

exit;

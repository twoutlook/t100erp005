/* 
================================================================================
檔案代號:gcak_t
檔案名稱:券發行單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcak_t
(
gcakent       number(5)      ,/* 企業編號 */
gcaksite       varchar2(10)      ,/* 營運據點 */
gcakunit       varchar2(10)      ,/* 應用組織 */
gcakdocno       varchar2(20)      ,/* 單據編號 */
gcakdocdt       date      ,/* 單據日期 */
gcak001       varchar2(20)      ,/* 空白券雜發單號 */
gcakstus       varchar2(10)      ,/* 狀態碼 */
gcakownid       varchar2(20)      ,/* 資料所有者 */
gcakowndp       varchar2(10)      ,/* 資料所屬部門 */
gcakcrtid       varchar2(20)      ,/* 資料建立者 */
gcakcrtdp       varchar2(10)      ,/* 資料建立部門 */
gcakcrtdt       timestamp(0)      ,/* 資料創建日 */
gcakmodid       varchar2(20)      ,/* 資料修改者 */
gcakmoddt       timestamp(0)      ,/* 最近修改日 */
gcakcnfid       varchar2(20)      ,/* 資料確認者 */
gcakcnfdt       timestamp(0)      ,/* 資料確認日 */
gcakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcak_t add constraint gcak_pk primary key (gcakent,gcakdocno) enable validate;

create unique index gcak_pk on gcak_t (gcakent,gcakdocno);

grant select on gcak_t to tiptop;
grant update on gcak_t to tiptop;
grant delete on gcak_t to tiptop;
grant insert on gcak_t to tiptop;

exit;

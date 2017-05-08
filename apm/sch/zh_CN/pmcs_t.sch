/* 
================================================================================
檔案代號:pmcs_t
檔案名稱:庫存組織要貨範圍設定-供貨對象範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmcs_t
(
pmcsent       number(5)      ,/* 企業編號 */
pmcssite       varchar2(10)      ,/* 營運據點 */
pmcs001       varchar2(10)      ,/* 庫位編號 */
pmcs002       varchar2(10)      ,/* 供貨對象組織編號 */
pmcsstus       varchar2(10)      ,/* 狀態 */
pmcsownid       varchar2(20)      ,/* 資料所有者 */
pmcsowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcscrtid       varchar2(20)      ,/* 資料建立者 */
pmcscrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcscrtdt       timestamp(0)      ,/* 資料創建日 */
pmcsmodid       varchar2(20)      ,/* 資料修改者 */
pmcsmoddt       timestamp(0)      ,/* 最近修改日 */
pmcsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcs_t add constraint pmcs_pk primary key (pmcsent,pmcssite,pmcs001,pmcs002) enable validate;

create unique index pmcs_pk on pmcs_t (pmcsent,pmcssite,pmcs001,pmcs002);

grant select on pmcs_t to tiptop;
grant update on pmcs_t to tiptop;
grant delete on pmcs_t to tiptop;
grant insert on pmcs_t to tiptop;

exit;

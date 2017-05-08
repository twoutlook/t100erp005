/* 
================================================================================
檔案代號:pmcq_t
檔案名稱:庫存組織要貨範圍設定-產品範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmcq_t
(
pmcqent       number(5)      ,/* 企業編號 */
pmcqsite       varchar2(10)      ,/* 營運據點 */
pmcq001       varchar2(10)      ,/* 庫位編號 */
pmcq002       varchar2(10)      ,/* 產品屬性類型 */
pmcq003       varchar2(40)      ,/* 屬性值編號 */
pmcqstus       varchar2(10)      ,/* 狀態 */
pmcqownid       varchar2(20)      ,/* 資料所有者 */
pmcqowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcqcrtid       varchar2(20)      ,/* 資料建立者 */
pmcqcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcqcrtdt       timestamp(0)      ,/* 資料創建日 */
pmcqmodid       varchar2(20)      ,/* 資料修改者 */
pmcqmoddt       timestamp(0)      ,/* 最近修改日 */
pmcqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcq_t add constraint pmcq_pk primary key (pmcqent,pmcqsite,pmcq001,pmcq002,pmcq003) enable validate;

create unique index pmcq_pk on pmcq_t (pmcqent,pmcqsite,pmcq001,pmcq002,pmcq003);

grant select on pmcq_t to tiptop;
grant update on pmcq_t to tiptop;
grant delete on pmcq_t to tiptop;
grant insert on pmcq_t to tiptop;

exit;

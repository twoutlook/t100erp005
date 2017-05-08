/* 
================================================================================
檔案代號:pmcl_t
檔案名稱:供應商評核綜合得分調整單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmcl_t
(
pmclstus       varchar2(10)      ,/* 狀態碼 */
pmclent       number(5)      ,/* 企業編號 */
pmcldocno       varchar2(20)      ,/* 單據編號 */
pmcldocdt       date      ,/* 單據日期 */
pmclownid       varchar2(20)      ,/* 資料所有者 */
pmclowndp       varchar2(10)      ,/* 資料所屬部門 */
pmclcrtid       varchar2(20)      ,/* 資料建立者 */
pmclcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmclcrtdt       timestamp(0)      ,/* 資料創建日 */
pmclmodid       varchar2(20)      ,/* 資料修改者 */
pmclmoddt       timestamp(0)      ,/* 最近修改日 */
pmclcnfid       varchar2(20)      ,/* 資料確認者 */
pmclcnfdt       timestamp(0)      ,/* 資料確認日 */
pmcl001       varchar2(20)      ,/* 調整人員 */
pmcl002       varchar2(10)      ,/* 調整部門 */
pmclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcl_t add constraint pmcl_pk primary key (pmclent,pmcldocno) enable validate;

create unique index pmcl_pk on pmcl_t (pmclent,pmcldocno);

grant select on pmcl_t to tiptop;
grant update on pmcl_t to tiptop;
grant delete on pmcl_t to tiptop;
grant insert on pmcl_t to tiptop;

exit;

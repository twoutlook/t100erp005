/* 
================================================================================
檔案代號:pmcc_t
檔案名稱:供應商評核項目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmcc_t
(
pmccent       number(5)      ,/* 企業編號 */
pmcc001       varchar2(10)      ,/* 評核期別 */
pmcc002       varchar2(10)      ,/* 評核品類 */
pmcc003       date      ,/* 評核開始日期 */
pmcc004       date      ,/* 評核結束日期 */
pmcc005       number(20,6)      ,/* 定量評核整體權重 */
pmcc006       number(20,6)      ,/* 定性評核整體權重 */
pmccstus       varchar2(10)      ,/* 狀態碼 */
pmccownid       varchar2(20)      ,/* 資料所有者 */
pmccowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcccrtid       varchar2(20)      ,/* 資料建立者 */
pmcccrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcccrtdt       timestamp(0)      ,/* 資料創建日 */
pmccmodid       varchar2(20)      ,/* 資料修改者 */
pmccmoddt       timestamp(0)      ,/* 最近修改日 */
pmccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcc_t add constraint pmcc_pk primary key (pmccent,pmcc001,pmcc002) enable validate;

create unique index pmcc_pk on pmcc_t (pmccent,pmcc001,pmcc002);

grant select on pmcc_t to tiptop;
grant update on pmcc_t to tiptop;
grant delete on pmcc_t to tiptop;
grant insert on pmcc_t to tiptop;

exit;

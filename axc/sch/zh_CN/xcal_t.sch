/* 
================================================================================
檔案代號:xcal_t
檔案名稱:標準成本_成本次要素檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcal_t
(
xcalent       number(5)      ,/* 企業編號 */
xcalownid       varchar2(20)      ,/* 資料所有者 */
xcalowndp       varchar2(10)      ,/* 資料所屬部門 */
xcalcrtid       varchar2(20)      ,/* 資料建立者 */
xcalcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcalcrtdt       timestamp(0)      ,/* 資料創建日 */
xcalmodid       varchar2(20)      ,/* 資料修改者 */
xcalmoddt       timestamp(0)      ,/* 最近修改日 */
xcalstus       varchar2(10)      ,/* 狀態碼 */
xcalsite       varchar2(10)      ,/* 營運據點 */
xcal001       varchar2(10)      ,/* 標準成本分類 */
xcal002       date      ,/* 生效日期 */
xcal003       date      ,/* 失效日期 */
xcal004       varchar2(40)      ,/* 物料編號 */
xcal005       varchar2(10)      ,/* 成本次要素 */
xcal006       varchar2(10)      ,/* 幣種 */
xcal007       number(20,6)      ,/* 成本 */
xcalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcal_t add constraint xcal_pk primary key (xcalent,xcalsite,xcal001,xcal002,xcal003,xcal004,xcal005) enable validate;

create unique index xcal_pk on xcal_t (xcalent,xcalsite,xcal001,xcal002,xcal003,xcal004,xcal005);

grant select on xcal_t to tiptop;
grant update on xcal_t to tiptop;
grant delete on xcal_t to tiptop;
grant insert on xcal_t to tiptop;

exit;

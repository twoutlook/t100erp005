/* 
================================================================================
檔案代號:rtax_t
檔案名稱:品類基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtax_t
(
rtaxent       number(5)      ,/* 企業編號 */
rtaxunit       varchar2(10)      ,/* 應用組織 */
rtax001       varchar2(10)      ,/* 品類編號 */
rtax002       varchar2(10)      ,/* 分類類別 */
rtax003       varchar2(10)      ,/* 上級品類編號 */
rtax004       number(5,0)      ,/* 層級 */
rtax005       number(5,0)      ,/* 下級品類數 */
rtax006       varchar2(10)      ,/* 所屬一級品類 */
rtax007       varchar2(10)      ,/* 主分群碼 */
rtax008       varchar2(10)      ,/* no use */
rtaxstus       varchar2(10)      ,/* 狀態碼 */
rtaxownid       varchar2(20)      ,/* 資料所有者 */
rtaxowndp       varchar2(10)      ,/* 資料所屬部門 */
rtaxcrtid       varchar2(20)      ,/* 資料建立者 */
rtaxcrtdt       timestamp(0)      ,/* 資料創建日 */
rtaxcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtaxmodid       varchar2(20)      ,/* 資料修改者 */
rtaxmoddt       timestamp(0)      ,/* 最近修改日 */
rtax009       varchar2(1)      ,/* 檢驗否 */
rtax010       number(20,6)      ,/* 商品臨期比例 */
rtax011       varchar2(10)      ,/* 臨期控管方式 */
rtaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtax_t add constraint rtax_pk primary key (rtaxent,rtax001) enable validate;

create  index rtax_01 on rtax_t (rtax003);
create  index rtax_02 on rtax_t (rtax006);
create unique index rtax_pk on rtax_t (rtaxent,rtax001);

grant select on rtax_t to tiptop;
grant update on rtax_t to tiptop;
grant delete on rtax_t to tiptop;
grant insert on rtax_t to tiptop;

exit;

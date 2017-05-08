/* 
================================================================================
檔案代號:rtjo_t
檔案名稱:銷售整合發卡明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtjo_t
(
rtjoent       number(5)      ,/* 企業編號 */
rtjosite       varchar2(10)      ,/* 營運據點 */
rtjounit       varchar2(10)      ,/* 應用組織 */
rtjodocno       varchar2(20)      ,/* 單據編號 */
rtjoseq       number(10,0)      ,/* 項次 */
rtjo001       varchar2(30)      ,/* 開始卡號 */
rtjo002       varchar2(30)      ,/* 結束卡號 */
rtjo003       varchar2(10)      ,/* 卡種編號 */
rtjo004       varchar2(30)      ,/* 會員編號 */
rtjo005       number(20,6)      ,/* 卡張數 */
rtjo006       number(20,6)      ,/* 單張購卡金額 */
rtjo007       number(20,6)      ,/* 總購卡金額 */
rtjo008       number(20,6)      ,/* 單張儲值金額 */
rtjo009       number(20,6)      ,/* 儲值折扣率% */
rtjo010       number(20,6)      ,/* 單張加值金額 */
rtjo011       number(20,6)      ,/* 總儲值金額 */
rtjo012       number(20,6)      ,/* 應收金額 */
rtjo013       varchar2(10)      ,/* 庫區 */
rtjo014       varchar2(1)      ,/* 發卡時記錄贈品否 */
rtjoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjo_t add constraint rtjo_pk primary key (rtjoent,rtjodocno,rtjoseq) enable validate;

create unique index rtjo_pk on rtjo_t (rtjoent,rtjodocno,rtjoseq);

grant select on rtjo_t to tiptop;
grant update on rtjo_t to tiptop;
grant delete on rtjo_t to tiptop;
grant insert on rtjo_t to tiptop;

exit;

/* 
================================================================================
檔案代號:mmea_t
檔案名稱:會員卡發卡資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmea_t
(
mmeaent       number(5)      ,/* 企業編號 */
mmeasite       varchar2(10)      ,/* 營運據點 */
mmeaunit       varchar2(10)      ,/* 應用組織 */
mmeadocno       varchar2(20)      ,/* 單據編號 */
mmeaseq       number(10,0)      ,/* 項次 */
mmea001       varchar2(30)      ,/* 開始卡號 */
mmea002       varchar2(30)      ,/* 結束卡號 */
mmea003       varchar2(10)      ,/* 卡種編號 */
mmea004       varchar2(30)      ,/* 會員編號 */
mmea005       number(20,6)      ,/* 卡張數 */
mmea006       number(20,6)      ,/* 單張購卡金額 */
mmea007       number(20,6)      ,/* 總購卡金額 */
mmea008       number(20,6)      ,/* 單張儲值金額 */
mmea009       number(20,6)      ,/* 儲值折扣率% */
mmea010       number(20,6)      ,/* 單張加值金額 */
mmea011       number(20,6)      ,/* 總儲值金額 */
mmea012       number(20,6)      ,/* 應收金額 */
mmea013       varchar2(10)      ,/* 庫區 */
mmeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmeaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmea014       varchar2(1)      ,/* 發卡時記錄贈品否 */
mmea015       varchar2(30)      ,/* 活動規則編號 */
mmea016       varchar2(10)      /* 活動規則版本 */
);
alter table mmea_t add constraint mmea_pk primary key (mmeaent,mmeadocno,mmeaseq) enable validate;

create unique index mmea_pk on mmea_t (mmeaent,mmeadocno,mmeaseq);

grant select on mmea_t to tiptop;
grant update on mmea_t to tiptop;
grant delete on mmea_t to tiptop;
grant insert on mmea_t to tiptop;

exit;

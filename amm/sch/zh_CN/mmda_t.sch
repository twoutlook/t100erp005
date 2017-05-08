/* 
================================================================================
檔案代號:mmda_t
檔案名稱:會員卡資訊重計變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmda_t
(
mmdaent       number(5)      ,/* 企業編號 */
mmdaunit       varchar2(10)      ,/* 應用組織 */
mmdasite       varchar2(10)      ,/* 營運據點 */
mmdadocno       varchar2(20)      ,/* 單號 */
mmdadocdt       date      ,/* 單據日期 */
mmda001       varchar2(10)      ,/* 重計算類型 */
mmda002       varchar2(10)      ,/* 理由碼 */
mmdaownid       varchar2(20)      ,/* 資料所有者 */
mmdaowndp       varchar2(10)      ,/* 資料所屬部門 */
mmdacrtid       varchar2(20)      ,/* 資料建立者 */
mmdacrtdp       varchar2(10)      ,/* 資料建立部門 */
mmdacrtdt       timestamp(0)      ,/* 資料創建日 */
mmdamodid       varchar2(20)      ,/* 資料修改者 */
mmdamoddt       timestamp(0)      ,/* 最近修改日 */
mmdastus       varchar2(10)      ,/* 狀態碼 */
mmdacnfid       varchar2(20)      ,/* 資料確認者 */
mmdacnfdt       timestamp(0)      ,/* 資料確認日 */
mmdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmda_t add constraint mmda_pk primary key (mmdaent,mmdadocno) enable validate;

create unique index mmda_pk on mmda_t (mmdaent,mmdadocno);

grant select on mmda_t to tiptop;
grant update on mmda_t to tiptop;
grant delete on mmda_t to tiptop;
grant insert on mmda_t to tiptop;

exit;

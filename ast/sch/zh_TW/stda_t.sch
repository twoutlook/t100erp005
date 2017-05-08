/* 
================================================================================
檔案代號:stda_t
檔案名稱:內部結算參數設定資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stda_t
(
stdaent       number(5)      ,/* 企業編號 */
stda001       varchar2(10)      ,/* 業務類型 */
stda002       varchar2(10)      ,/* 內部交易類型 */
stda003       number(5,0)      ,/* 交易方向 */
stda004       varchar2(10)      ,/* 聯動交易類型(入) */
stda005       varchar2(10)      ,/* 聯動交易類型(出) */
stdaownid       varchar2(20)      ,/* 資料所有者 */
stdaowndp       varchar2(10)      ,/* 資料所屬部門 */
stdacrtid       varchar2(20)      ,/* 資料建立者 */
stdacrtdp       varchar2(10)      ,/* 資料建立部門 */
stdacrtdt       timestamp(0)      ,/* 資料創建日 */
stdamodid       varchar2(20)      ,/* 資料修改者 */
stdamoddt       timestamp(0)      ,/* 最近修改日 */
stdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stda_t add constraint stda_pk primary key (stdaent,stda001,stda002) enable validate;

create unique index stda_pk on stda_t (stdaent,stda001,stda002);

grant select on stda_t to tiptop;
grant update on stda_t to tiptop;
grant delete on stda_t to tiptop;
grant insert on stda_t to tiptop;

exit;

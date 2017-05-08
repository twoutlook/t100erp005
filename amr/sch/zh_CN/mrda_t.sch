/* 
================================================================================
檔案代號:mrda_t
檔案名稱:保養校驗單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mrda_t
(
mrdaent       number(5)      ,/* 企業編號 */
mrdasite       varchar2(10)      ,/* 營運據點 */
mrdadocno       varchar2(20)      ,/* 保校單號 */
mrdadocdt       date      ,/* 保校日期 */
mrda001       varchar2(20)      ,/* 保養人員 */
mrda002       varchar2(10)      ,/* 保養部門 */
mrda003       varchar2(20)      ,/* 資源編號 */
mrda004       varchar2(10)      ,/* 保修類型 */
mrda005       varchar2(10)      ,/* 保修週期 */
mrda006       varchar2(10)      ,/* 資源分類 */
mrda007       varchar2(10)      ,/* 廠牌 */
mrda008       varchar2(10)      ,/* 保養後資源狀態 */
mrda009       date      ,/* 上次保養日 */
mrda010       number(15,3)      ,/* 保養花費時間 */
mrda011       varchar2(10)      ,/* 時間單位 */
mrda012       varchar2(20)      ,/* 資源維修單號 */
mrdaownid       varchar2(20)      ,/* 資料所有者 */
mrdaowndp       varchar2(10)      ,/* 資料所屬部門 */
mrdacrtid       varchar2(20)      ,/* 資料建立者 */
mrdacrtdp       varchar2(10)      ,/* 資料建立部門 */
mrdacrtdt       timestamp(0)      ,/* 資料創建日 */
mrdamodid       varchar2(20)      ,/* 資料修改者 */
mrdamoddt       timestamp(0)      ,/* 最近修改日 */
mrdacnfid       varchar2(20)      ,/* 資料確認者 */
mrdacnfdt       timestamp(0)      ,/* 資料確認日 */
mrdastus       varchar2(10)      ,/* 狀態碼 */
mrdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrda_t add constraint mrda_pk primary key (mrdaent,mrdadocno) enable validate;

create unique index mrda_pk on mrda_t (mrdaent,mrdadocno);

grant select on mrda_t to tiptop;
grant update on mrda_t to tiptop;
grant delete on mrda_t to tiptop;
grant insert on mrda_t to tiptop;

exit;

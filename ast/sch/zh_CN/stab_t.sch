/* 
================================================================================
檔案代號:stab_t
檔案名稱:合約計算及條件基準基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stab_t
(
stabent       number(5)      ,/* 企業編號 */
stab001       varchar2(10)      ,/* 基準編號 */
stab002       varchar2(1)      ,/* 含稅否 */
stab003       varchar2(1)      ,/* 收貨入庫 */
stab004       varchar2(1)      ,/* 退廠 */
stab005       varchar2(1)      ,/* 配送物流 */
stab006       varchar2(1)      ,/* 跨區調撥 */
stab007       varchar2(1)      ,/* 訂貨 */
stab008       varchar2(1)      ,/* 实收金额 */
stab009       varchar2(1)      ,/* 銷退 */
stab010       varchar2(1)      ,/* 包含折扣 */
stab011       varchar2(255)      ,/* 備註 */
stabownid       varchar2(20)      ,/* 資料所有者 */
stabowndp       varchar2(10)      ,/* 資料所屬部門 */
stabcrtid       varchar2(20)      ,/* 資料建立者 */
stabcrtdp       varchar2(10)      ,/* 資料建立部門 */
stabcrtdt       timestamp(0)      ,/* 資料創建日 */
stabmodid       varchar2(20)      ,/* 資料修改者 */
stabmoddt       timestamp(0)      ,/* 最近修改日 */
stabstus       varchar2(10)      ,/* 狀態碼 */
stabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stab012       varchar2(1)      ,/* 款別金額 */
stab013       varchar2(1)      /* 會員積分 */
);
alter table stab_t add constraint stab_pk primary key (stabent,stab001) enable validate;

create unique index stab_pk on stab_t (stabent,stab001);

grant select on stab_t to tiptop;
grant update on stab_t to tiptop;
grant delete on stab_t to tiptop;
grant insert on stab_t to tiptop;

exit;

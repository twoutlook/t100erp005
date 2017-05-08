/* 
================================================================================
檔案代號:ineh_t
檔案名稱:盤點維護資料明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ineh_t
(
inehent       number(5)      ,/* 企業編號 */
inehunit       varchar2(10)      ,/* 應用組織 */
inehsite       varchar2(10)      ,/* 營運據點 */
inehdocno       varchar2(20)      ,/* 單據編號 */
inehseq       number(10,0)      ,/* 項次 */
ineh001       varchar2(40)      ,/* 商品編號 */
ineh002       varchar2(40)      ,/* 商品條碼 */
ineh003       varchar2(256)      ,/* 商品特徵 */
ineh004       varchar2(10)      ,/* 庫位 */
ineh005       varchar2(10)      ,/* 儲位 */
ineh006       varchar2(30)      ,/* 批號 */
ineh007       varchar2(40)      ,/* 貨架位置 */
ineh008       varchar2(10)      ,/* 單位 */
ineh009       number(20,6)      ,/* 本次輸入數量 */
ineh010       number(20,6)      ,/* 帳面數量 */
ineh011       number(20,6)      ,/* 初盤數量 */
ineh012       number(20,6)      ,/* 複盤數量 */
ineh013       number(20,6)      ,/* 抽盤數量 */
ineh014       number(20,6)      ,/* 實盤數量 */
ineh015       number(20,6)      ,/* 差異數量 */
ineh016       number(20,6)      ,/* 最新進價 */
ineh017       number(20,6)      ,/* 售價 */
ineh018       varchar2(10)      ,/* 理由碼 */
ineh019       varchar2(255)      ,/* 備註 */
inehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inehud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ineh020       varchar2(20)      ,/* 來源單號 */
ineh021       number(10,0)      /* 來源項次 */
);
alter table ineh_t add constraint ineh_pk primary key (inehent,inehsite,inehdocno,inehseq) enable validate;

create  index ineh_n on ineh_t (inehent,inehsite,inehdocno,inehseq,ineh015);
create unique index ineh_pk on ineh_t (inehent,inehsite,inehdocno,inehseq);

grant select on ineh_t to tiptop;
grant update on ineh_t to tiptop;
grant delete on ineh_t to tiptop;
grant insert on ineh_t to tiptop;

exit;

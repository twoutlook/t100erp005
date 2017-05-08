/* 
================================================================================
檔案代號:srza_t
檔案名稱:重覆性生產計畫基礎資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table srza_t
(
srzaent       number(5)      ,/* 企業編號 */
srzasite       varchar2(10)      ,/* 營運據點 */
srzaownid       varchar2(20)      ,/* 資料所有者 */
srzaowndp       varchar2(10)      ,/* 資料所屬部門 */
srzacrtid       varchar2(20)      ,/* 資料建立者 */
srzacrtdp       varchar2(10)      ,/* 資料建立部門 */
srzacrtdt       timestamp(0)      ,/* 資料創建日 */
srzamodid       varchar2(20)      ,/* 資料修改者 */
srzamoddt       timestamp(0)      ,/* 最近修改日 */
srzastus       varchar2(10)      ,/* 狀態碼 */
srza001       varchar2(10)      ,/* 生產計畫編號 */
srza002       varchar2(80)      ,/* 說明 */
srza003       varchar2(1)      ,/* 可修改當天以前排程 */
srza004       varchar2(1)      ,/* 使用製程 */
srza005       varchar2(1)      ,/* FQC */
srza006       varchar2(1)      ,/* 允許發料套數超過計畫數量 */
srza007       varchar2(1)      ,/* 允許發BOM不存在之料件 */
srza008       varchar2(1)      ,/* 允許事後報工 */
srza009       varchar2(1)      ,/* 當站報廢使用申請流程 */
srza010       varchar2(1)      ,/* 重工轉出使用申請流程 */
srza011       varchar2(1)      ,/* 盤點分攤方式 */
srza012       varchar2(10)      ,/* 生管控制組 */
srzaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srzaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srzaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srzaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srzaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srzaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srzaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srzaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srzaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srzaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srzaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srzaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srzaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srzaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srzaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srzaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srzaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srzaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srzaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srzaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srzaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srzaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srzaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srzaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srzaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srzaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srzaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srzaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srzaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srzaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srza_t add constraint srza_pk primary key (srzaent,srzasite,srza001) enable validate;

create unique index srza_pk on srza_t (srzaent,srzasite,srza001);

grant select on srza_t to tiptop;
grant update on srza_t to tiptop;
grant delete on srza_t to tiptop;
grant insert on srza_t to tiptop;

exit;

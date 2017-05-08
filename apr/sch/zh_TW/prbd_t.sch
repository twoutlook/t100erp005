/* 
================================================================================
檔案代號:prbd_t
檔案名稱:市場調查結果資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbd_t
(
prbdent       number(5)      ,/* 企業編號 */
prbdunit       varchar2(10)      ,/* 應用組織 */
prbdsite       varchar2(10)      ,/* 營運據點 */
prbddocno       varchar2(20)      ,/* 單據編號 */
prbddocdt       date      ,/* 單據日期 */
prbd001       varchar2(20)      ,/* 計劃單號 */
prbd002       number(10)      ,/* 市調類型 */
prbd003       varchar2(10)      ,/* 市調門店 */
prbd004       varchar2(10)      ,/* 競爭門店 */
prbd005       date      ,/* 開始日期 */
prbd006       date      ,/* 結束日期 */
prbd007       varchar2(20)      ,/* 人員 */
prbd008       varchar2(10)      ,/* 部門 */
prbd009       varchar2(255)      ,/* 備註 */
prbd010       varchar2(20)      ,/* 撥轉調價單號 */
prbdstus       varchar2(1)      ,/* 狀態 */
prbdownid       varchar2(20)      ,/* 資料所有者 */
prbdowndp       varchar2(10)      ,/* 資料所屬部門 */
prbdcrtid       varchar2(20)      ,/* 資料建立者 */
prbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
prbdcrtdt       timestamp(0)      ,/* 資料創建日 */
prbdmodid       varchar2(20)      ,/* 資料修改者 */
prbdmoddt       timestamp(0)      ,/* 最近修改日 */
prbdcnfid       varchar2(20)      ,/* 資料確認者 */
prbdcnfdt       timestamp(0)      ,/* 資料確認日 */
prbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbd_t add constraint prbd_pk primary key (prbdent,prbddocno) enable validate;

create unique index prbd_pk on prbd_t (prbdent,prbddocno);

grant select on prbd_t to tiptop;
grant update on prbd_t to tiptop;
grant delete on prbd_t to tiptop;
grant insert on prbd_t to tiptop;

exit;

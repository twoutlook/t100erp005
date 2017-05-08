/* 
================================================================================
檔案代號:psbb_t
檔案名稱:MDS淨需求檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psbb_t
(
psbbent       number(5)      ,/* 企業編號 */
psbbsite       varchar2(10)      ,/* 營運據點 */
psbb001       varchar2(10)      ,/* MDS編號 */
psbb002       varchar2(10)      ,/* 單據類型 */
psbbdocno       varchar2(20)      ,/* 單據編號 */
psbbseq       number(10,0)      ,/* 項次 */
psbbseq1       number(10,0)      ,/* 項序 */
psbbseq2       number(10,0)      ,/* 分批序 */
psbb003       varchar2(40)      ,/* 料件編號 */
psbb004       varchar2(256)      ,/* 產品特徵 */
psbb005       varchar2(10)      ,/* 單位 */
psbb006       number(20,6)      ,/* 需求數量 */
psbb007       date      ,/* 需求日期 */
psbb008       varchar2(10)      ,/* 客戶編號 */
psbb009       varchar2(20)      ,/* 業務員 */
psbb010       varchar2(10)      ,/* 銷售組織 */
psbb011       varchar2(10)      ,/* 通路 */
psbb012       number(10,0)      ,/* 優先順序 */
psbb013       varchar2(1)      ,/* 嚴守交期 */
psbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psbb_t add constraint psbb_pk primary key (psbbent,psbbsite,psbb001,psbbdocno,psbbseq,psbbseq1,psbbseq2) enable validate;

create unique index psbb_pk on psbb_t (psbbent,psbbsite,psbb001,psbbdocno,psbbseq,psbbseq1,psbbseq2);

grant select on psbb_t to tiptop;
grant update on psbb_t to tiptop;
grant delete on psbb_t to tiptop;
grant insert on psbb_t to tiptop;

exit;

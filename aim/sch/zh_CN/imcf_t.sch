/* 
================================================================================
檔案代號:imcf_t
檔案名稱:料件據點生管分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcf_t
(
imcfsite       varchar2(10)      ,/* 營運據點 */
imcfent       number(5)      ,/* 企業編號 */
imcfownid       varchar2(20)      ,/* 資料所有者 */
imcfowndp       varchar2(10)      ,/* 資料所屬部門 */
imcfcrtid       varchar2(20)      ,/* 資料建立者 */
imcfcrtdp       varchar2(10)      ,/* 資料建立部門 */
imcfcrtdt       timestamp(0)      ,/* 資料創建日 */
imcfmodid       varchar2(20)      ,/* 資料修改者 */
imcfmoddt       timestamp(0)      ,/* 最近修改日 */
imcfstus       varchar2(10)      ,/* 狀態碼 */
imcf011       varchar2(10)      ,/* 生管分群 */
imcf012       varchar2(20)      ,/* 計劃員 */
imcf013       varchar2(10)      ,/* 生產型態 */
imcf014       varchar2(10)      ,/* 領發料機制 */
imcf015       number(20,6)      ,/* 生產損耗率 */
imcf016       varchar2(10)      ,/* 生產單位 */
imcf017       number(20,6)      ,/* 生產單位批量 */
imcf018       number(20,6)      ,/* 最小生產量 */
imcf019       varchar2(10)      ,/* 生產批量控管方式 */
imcf020       number(20,6)      ,/* 生產超交率 */
imcf021       varchar2(10)      ,/* 生產命令展開選項 */
imcf022       number(20,6)      ,/* 工單拆分批量 */
imcf023       varchar2(10)      ,/* 必要性質 */
imcf031       varchar2(5)      ,/* 預設工單別 */
imcf032       varchar2(40)      ,/* 製程料號 */
imcf033       varchar2(10)      ,/* 預設製程編號 */
imcf034       varchar2(10)      ,/* 預設部門/廠商 */
imcf035       varchar2(10)      ,/* 預設成本中心 */
imcf036       varchar2(1)      ,/* 允許需求合併生產 */
imcf037       varchar2(30)      ,/* 預設BOM特性 */
imcf041       varchar2(10)      ,/* 預設入庫庫位 */
imcf042       varchar2(10)      ,/* 預設入庫儲位 */
imcf051       number(15,3)      ,/* 標準人工工時 */
imcf052       number(15,3)      ,/* 標準機器工時 */
imcf061       varchar2(1)      ,/* MPS計算 */
imcf062       number(15,3)      ,/* 預設無效天數 */
imcf063       number(15,3)      ,/* No use */
imcf064       number(15,3)      ,/* 供給匯整時距 */
imcf065       number(20,6)      ,/* 建議新單量 */
imcf066       date      ,/* 預計停產日 */
imcf071       number(15,3)      ,/* 固定生產前置時間 */
imcf072       number(15,3)      ,/* 變動生產前置時間 */
imcf073       number(20,6)      ,/* 變動批量 */
imcf074       number(15,3)      ,/* QC前置時間 */
imcf075       number(15,3)      ,/* 累計前置時間 */
imcf076       number(15,3)      ,/* 嚴守交期前置時間 */
imcf077       number(20,6)      ,/* 計劃批次移轉量 */
imcf078       number(15,3)      ,/* 物規劃移轉時間 */
imcf079       number(15,3)      ,/* 主料需求保留天數 */
imcf080       varchar2(1)      ,/* 關鍵物料 */
imcf081       varchar2(10)      ,/* 發料單位 */
imcf082       number(20,6)      ,/* 發料單位批量 */
imcf083       number(20,6)      ,/* 最小發料數量 */
imcf084       varchar2(10)      ,/* 發料批量控管方式 */
imcf085       number(15,3)      ,/* 發料調整時間 */
imcf091       varchar2(1)      ,/* 倒扣料 */
imcf092       varchar2(1)      ,/* 發料前調整 */
imcf101       varchar2(10)      ,/* 預設發料庫位 */
imcf102       varchar2(10)      ,/* 預設發料儲位 */
imcf103       varchar2(10)      ,/* 預設退料庫位 */
imcf104       varchar2(10)      ,/* 預設退料儲位 */
imcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcf_t add constraint imcf_pk primary key (imcfsite,imcfent,imcf011) enable validate;

create unique index imcf_pk on imcf_t (imcfsite,imcfent,imcf011);

grant select on imcf_t to tiptop;
grant update on imcf_t to tiptop;
grant delete on imcf_t to tiptop;
grant insert on imcf_t to tiptop;

exit;
